//
//  NSDateComponents.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 11/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation

extension NSDateComponents {
    
    class func fromRange(startDate: NSDate, _ endDate: NSDate) -> NSDateComponents {
        return NSCalendar.currentCalendar().components([.Day, .Hour, .Minute], fromDate: startDate, toDate: endDate, options: NSCalendarOptions.init(rawValue: 0))
    }
    
    var string:String {
        let (days, hours, minutes) = (self.day, self.hour, self.minute)
        
        var components = [String]()
        
        if days > 0 {
            components.append("\(days) day\(days > 1 ? "s" : "")")
        }
        
        if hours > 0 {
            components.append(hours > 0 ? "\(hours) hour\(hours > 1 ? "s" : "")" : "")
        }
        
        if minutes > 0 {
            components.append("\(minutes) min")
        }
        
        if components.count > 0 {
            return components.joinWithSeparator(", ")
        } else {
            return "None"
        }
    }
}