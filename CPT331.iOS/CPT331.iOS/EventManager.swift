//
//  EventManager.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 20/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class EventManager: JSONAPI {
    static let sharedInstance = EventManager()
    
    // TODO: move domain to info.plist
    private let ENDPOINT = "http://ec2-52-32-105-85.us-west-2.compute.amazonaws.com/api/Event/EventsByCoordinate"
    
    // Prevent external initialization
    private override init() {}
    
    // Cache all incoming events
    private var eventCache = [Int:Event]()
    
    
    func getEvents(atCoordinate coordinate: CLLocationCoordinate2D, withinRadius radius:Double, days:Int=7, completion: ([Event]?) -> ()) {
        
//        // BENCHMARKING
//        let startTime:CFTimeInterval = CACurrentMediaTime();
        
        let parameters:[String:AnyObject] = [
            "latitude": coordinate.latitude,
            "longitude": coordinate.longitude,
            "radius": radius
        ]
        
        fetchJSON(self.ENDPOINT, parameters: parameters) { json in
            
//            // BENCHMARKING
//            let endTime:CFTimeInterval = CACurrentMediaTime();
//            print(String(format: "API Request: %gms", (endTime - startTime)*1000));
            
            if let events = json {
                var parsedEvents = [Event]()
                
                for (_,event) in events {
                    // Skip events that don't have an ID (This probably will never happen)
                    guard let id = event["ID"].int else {
                        continue
                    }
                    
                    // Optional fields
                    let name = event["Name"].string
                    let description = event["Description"].string
                    let address = event["Address"].string
                    var beginDateTime:NSDate?
                    var endDateTime:NSDate?
                    var coordinate:CLLocationCoordinate2D?
                    var subcategory:EventSubcategry?
                    var url:NSURL?
                    var thumbnailURL:NSURL?
                    var bannerURL:NSURL?
                    
                    // Get event begin and end times
                    let dateFormatter = NSDateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    
                    if let rawBegin = event["BeginDateTime"].string {
                        beginDateTime = NSDate.fromISO8601(rawBegin)
                    }
                    
                    if let rawEnd = event["EndDateTime"].string {
                        endDateTime = NSDate.fromISO8601(rawEnd)
                    }
                    
                    // Get coordinate
                    if let lat = event["Latitude"].double, let lng = event["Longitude"].double {
                        coordinate = CLLocationCoordinate2D(latitude: lat, longitude: lng)
                    }
                    
                    // Get subcategory
                    if let subcategoryName = event["Categories"].array?[0]["Name"].string {
                        subcategory = EventSubcategry.fromString(subcategoryName)
                    } else {
                        subcategory = EventSubcategry.Generic
                    }
                    
                    // Get event callback url
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
                            
                            let height = image["Height"].int
                            let width = image["Width"].int
                            
                            if height == 75 && width == 75 {
                                thumbnailURL = url
                            } else if height == 280 && width == 650 {
                                bannerURL = url
                            }
                            
                            // Break out of loop early if both images have been found
                            if thumbnailURL != nil && bannerURL != nil {
                                break
                            }
                        }
                    }
                    
                    // Update cached event if it exists
                    if let cachedEvent = self.eventCache[id] {
                        cachedEvent.update(
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
                        
                        parsedEvents.append(cachedEvent)
                        
                    // Otherwise create a new event and add to cache
                    } else {
                        let newEvent = Event(
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
                        
                        self.eventCache[id] = newEvent
                        parsedEvents.append(newEvent)
                    }
                }
                
                completion(parsedEvents)
            } else {
                completion(nil)
            }
        }
    }
}