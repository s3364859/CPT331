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

enum EventField:String {
    case address    = "address"
    case category   = "category"
    case startDate  = "datetime_start"
    case endDate    = "datetime_end"
    case description = "description"
    case id         = "id"
    case cancelled  = "is_cancelled"
    case coordinate = "point"
    case name       = "name"
}



struct Event {
//    static let fields:[EventField] = [.id, .name, .coordinate]
    
    let id:Int
    let name:String
    let coordinate:CLLocationCoordinate2D
    
    init(id:Int, name:String, coordinate:CLLocationCoordinate2D) {
        self.id = id
        self.name = name
        self.coordinate = coordinate
    }
    
    func getDetails(completion: (EventDetail?) -> ()) {
        EventManager.getEvent(withId: self.id, completion: completion)
    }
}



struct EventDetail {
//    static let fields:[EventField] = [.id, .name, .coordinate, .startDate, .endDate, .coordinate, .description, .cancelled]
    
    let id:Int
    let name:String
    let coordinate:CLLocationCoordinate2D
    
    // Extra params
    let startDate:NSDate
    let endDate:NSDate
    let cancelled:Bool
    let description:String?
    let categories:[String]?
    
    init(id:Int, name:String, coordinate:CLLocationCoordinate2D, startDate:NSDate, endDate:NSDate, cancelled:Bool=false, description:String?=nil, categories:[String]?=nil) {
        self.id = id
        self.name = name
        self.coordinate = coordinate
        self.startDate = startDate
        self.endDate = endDate
        self.cancelled = cancelled
        self.categories = categories
        self.description = description
    }
}



class EventManager {
    private init() {}
    
    private static let endpoint = "http://api.eventfinda.com.au/v2/events.json"
    private static let username = "spationews"
    private static let password = "m34nzj4pvscm"
    
    private static var authToken:String {
        let credentialData = "\(username):\(password)".dataUsingEncoding(NSUTF8StringEncoding)!
        let base64Credentials = credentialData.base64EncodedStringWithOptions([])
        return "Basic \(base64Credentials)"
    }
    
    private static var defaultHeaders:[String:String] {
        return ["Authorization": authToken]
    }
    
    
    class func getEvent(withId id:Int, completion: (EventDetail?) -> ()) {
        completion(nil)
    }
    
    class func getEvents(atCoordinate coordinate: CLLocationCoordinate2D, withinRadius radius:Double, days:Int=7, completion: ([Event]?) -> ()) {
        let calendar = NSCalendar.currentCalendar()
        let now = NSDate()
        let future = calendar.dateByAddingUnit(.Day, value: days, toDate: NSDate(), options: [])
        
        // Data which should be returned
        let fields:[EventField] = [.id, .name, .coordinate]
        
        let parameters:[String:AnyObject] = [
            "rows": 20,
            "point": "\(coordinate.latitude),\(coordinate.longitude)",
            "radius": radius,
            "order": "date",
            "fields": "event:(\(fieldsAsString(fields)))",
            "start_date": now.asISO8601(),
            "end_date": future!.asISO8601()
        ]
        
        fetchJSON(endpoint, parameters: parameters, headers: defaultHeaders) { json in
            if let events = json?["events"] {
                var parsedEvents = [Event]()
                
                // Build markers
                for (_,event) in events {
                    let id = event["id"].int
                    let name = event["name"].string
                    let lat = event["point"]["lat"].double
                    let lng = event["point"]["lng"].double
                    
                    // Ensure all data has been returned
                    if id != nil && name != nil && lat != nil && lng != nil {
                        let coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: lng!)
                        
                        // Construct and append to array
                        parsedEvents.append(Event(id: id!, name: name!, coordinate: coordinate))
                    }
                }
                
                completion(parsedEvents)
            } else {
                completion(nil)
            }
        }
    }
    
    internal class func fetchJSON(endpoint:String, parameters:[String:AnyObject], headers:[String:String], completion: (JSON?) -> ()) {
        Alamofire.request(.GET, endpoint, parameters: parameters, headers: headers).responseJSON { response in
//            print(response)
            
            guard response.result.error == nil else {
                return completion(nil)
            }
            
            if let data = response.result.value {
                completion(JSON(data))
            } else {
                completion(nil)
            }
        }
    }
    
    internal class func fieldsAsString(fields: [EventField]) -> String {
        return fields.map{$0.rawValue}.joinWithSeparator(",")
    }
}