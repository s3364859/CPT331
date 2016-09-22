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
        let fields:[EventField] = [.id, .name, .coordinate, .category]
        
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
                    let category = event["category"]["name"].string
                    
                    // Ensure all data has been returned
                    if id != nil && name != nil && lat != nil && lng != nil {
                        let coordinate = CLLocationCoordinate2D(latitude: lat!, longitude: lng!)
                        
                        // Construct and append to array
                        parsedEvents.append(Event(id: id!, name: name!, coordinate: coordinate, category: category))
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