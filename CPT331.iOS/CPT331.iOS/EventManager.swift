//
//  EventManager.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 20/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit
import Mapbox
import Alamofire
import SwiftyJSON

/// Handles retrieval, parsing and caching of event data from the EventGuardian JSON API
class EventManager: JSONAPI {
    static let sharedInstance = EventManager()
    
    // TODO: move domain to info.plist
    /// EventGuardian API endpoint for event data
    private let ENDPOINT = "http://ec2-52-32-105-85.us-west-2.compute.amazonaws.com/api/Event/EventsByCoordinate"
    
    /// Stores all cached events
    private var eventCache = [Int:Event]()
    
    /// Singleton initializer
    private override init() {}
    
    
    
    // -----------------------------
    // MARK: Public functions
    // -----------------------------
    
    /**
        Synchronously fetches events from cache within the specified coordinate bounds.
     
        - Parameters:
            - bounds: the geographical coordinate abounds to search within
     
        - Returns: a dictionary of events (event id / event pairs)
     */
    func getEventsFromCache(withinBounds bounds: MGLCoordinateBounds) -> [Int:Event] {
        
        var filtered = [Int:Event]()
        for (_,cachedEvent) in self.eventCache {
            if let coord = cachedEvent.coordinate where coordinate(coord, isInsideBounds: bounds) {
                filtered[cachedEvent.id] = cachedEvent
            }
        }
        
        return filtered
    }
    
    
    /**
        Synchronously fetches events from cache within the specified radius of the specified coordinate.
     
        - Parameters:
            - coordinate: the geographical center of the search (latitude/longitude pair)
            - radius: the size of the search radius in Kilometers
        
        - Returns: a dictionary of events (event id / event pairs)
     */
    func getEventsFromCache(atCoordinate coordinate:CLLocationCoordinate2D, withinRadius radius:Double) -> [Int:Event] {
        // convert to meters
        let radius = radius * 1000
        
        var filtered = [Int:Event]()
        for (_,cachedEvent) in self.eventCache {
            if cachedEvent.coordinate?.distanceFrom(coordinate) <= radius {
                filtered[cachedEvent.id] = cachedEvent
            }
        }
        
        return filtered
    }
    
    
    /**
        Asynchronously fetches events from API within the specified radius of the specified coordinate.
     
        - Parameters:
            - coordinate: the geographical center of the search (latitude/longitude pair)
            - radius: the size of the search radius in Kilometers
            - completion: fired with a dictionary of events (event id / event pairs) once the data has been fetched and parsed
    */
    func getEventsFromAPI(atCoordinate coordinate: CLLocationCoordinate2D, withinRadius radius:Double, completion: ([Int:Event]?) -> ()) {
        let parameters:[String:AnyObject] = [
            "latitude": coordinate.latitude,
            "longitude": coordinate.longitude,
            "radius": radius
        ]
        
        fetchJSON(self.ENDPOINT, parameters: parameters) { json in
            
            if json != nil {
                let events = self.parseJSON(json!)
                completion(events)
                
            } else {
                completion(nil)
            }
        }
    }
    
    
    // -----------------------------
    // MARK: Internal functions
    // -----------------------------
    
    /**
        Helper function to determine if a specific coordinate is inside a coordinate region
     
        - Parameters:
            - coordinate: the specific coordinate to check
            - bounds: the coordinate bounds to match against
     
        - Returns: TRUE if inside, FALSE if outside
    */
    internal func coordinate(coordinate: CLLocationCoordinate2D, isInsideBounds bounds: MGLCoordinateBounds) -> Bool {
        return ((coordinate.latitude >= bounds.sw.latitude && coordinate.latitude <= bounds.ne.latitude) &&
            (coordinate.longitude >= bounds.sw.longitude && coordinate.longitude <= bounds.ne.longitude))
    }
    
    
    /**
        Parses json event array into an event dictionary
     
            Expected JSON Format:
            [
                {
                    ID: int,
                    Name: string,
                    Description: string,
                    Address: string,
                    BeginDateTime: string (ISO 8601),
                    EndDateTime: string (ISO 8601),
                    Latitude: double,
                    Longitude: double,
                    Category: int,
                    thumbnailURL: string,
                    bannerURL: string
                },
                ...
            ]
     
        - Parameters:
            - JSON: json object containing event data
     
        - Returns: event dictionary with event id's as the keys
    */
    internal func parseJSON(json:JSON) -> [Int:Event]? {
        var parsedEvents = [Int:Event]()
        
        for (_,event) in json {
            // Skip events that don't have an ID (This probably will never happen)
            guard let id = event["ID"].int else {
                continue
            }
            
            // Optional fields
            let name = event["Name"].string
            let description = event["Description"].string
            let address = event["Address"].string
            var coordinate:CLLocationCoordinate2D?
            var beginDateTime:NSDate?
            var endDateTime:NSDate?
            var url:NSURL?
            var thumbnailURL:NSURL?
            var bannerURL:NSURL?
            var subcategory:EventSubcategry?
            
            if let rawBeginDateTime = event["BeginDateTime"].string {
                beginDateTime = NSDate.fromISO8601(rawBeginDateTime)
            }
            
            if let rawEndDateTime = event["EndDateTime"].string {
                endDateTime = NSDate.fromISO8601(rawEndDateTime)
            }
            
            if let lat = event["Latitude"].double, let lng = event["Longitude"].double {
                coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
            }
            
            if let subcategoryName = event["Categories"].array?[0]["Name"].string {
                subcategory = EventSubcategry.fromString(subcategoryName)
            } else {
                subcategory = EventSubcategry.Generic
            }
            
            if let urlString = event["Url"].string {
                url = NSURL(string: urlString)
            }
            
            // Find banner and thumbnail images
            // TODO: Should this be done on serverside??
            if let images = event["Images"].array {
                for image in images {
                    // Skip images that don't have a url (This probably will never happen)
                    guard let urlString = image["Url"].string, let url = NSURL(string: urlString) else {
                        continue
                    }
                    
                    let width = image["Width"].int
                    let height = image["Height"].int
                    
                    if width == 75 && height == 75 {
                        thumbnailURL = url
                    } else if width == 650 && height == 280 {
                        bannerURL = url
                    }
                    
                    // Break out of loop early if both images have been found
                    if thumbnailURL != nil && bannerURL != nil {
                        break
                    }
                }
            }
            
            parsedEvents[id] = self.createOrUpdateEvent(
                id: id,
                name: name,
                desc: description,
                address: address,
                coordinate: coordinate,
                beginDateTime: beginDateTime,
                endDateTime: endDateTime,
                url: url,
                thumbnailURL: thumbnailURL,
                bannerURL: bannerURL,
                subcategory: subcategory
            )
        }
        
        return parsedEvents
    }
    
    
    
    /**
        Handles creating or updating events in the cache. If an object for the event exists in the cache already, it will be updated. Otherwise, a new event will be created and cached.
     
        - Parameters:
            - id: event id
            - name: event title
            - desc: a short description
            - address: human-readable street address
            - coordinate: geographical coordinate using latitude & longitude
            - beginDateTime: the date/time of when the event starts
            - endDateTime: the date/time of when the event ends
            - url: webpage link for the event on Eventfinda
            - thumbnailUrl: thumbnail image (75x75)
            - bannerUrl: banner image (650x280)
            - subcategory: the subcategory which the event belongs to
     
        - Returns: cached event object
    */
    internal func createOrUpdateEvent(id id:Int, name:String?, desc:String?, address:String?, coordinate:CLLocationCoordinate2D?, beginDateTime:NSDate?,endDateTime:NSDate?, url:NSURL?, thumbnailURL:NSURL?, bannerURL:NSURL?, subcategory:EventSubcategry?) -> Event {
        // Update cached event if it exists
        if let cachedEvent = self.eventCache[id] {
            cachedEvent.update(
                name: name,
                desc: desc,
                address: address,
                coordinate: coordinate,
                beginDateTime: beginDateTime,
                endDateTime: endDateTime,
                url: url,
                thumbnailURL: thumbnailURL,
                bannerURL: bannerURL,
                subcategory: subcategory
            )
            
            return cachedEvent
            
            // Otherwise create a new event and add to cache
        } else {
            let newEvent = Event(
                id: id,
                name: name,
                desc: desc,
                address: address,
                coordinate: coordinate,
                beginDateTime: beginDateTime,
                endDateTime: endDateTime,
                url: url,
                thumbnailURL: thumbnailURL,
                bannerURL: bannerURL,
                subcategory: subcategory
            )
            
            self.eventCache[id] = newEvent
            return newEvent
        }
    }
}