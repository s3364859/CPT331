//
//  NSDateComponents.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 11/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation

extension NSDateComponents {
    
    /// Constructs a NSDateCompontents object using date range
    class func fromRange(startDate: NSDate, _ endDate: NSDate) -> NSDateComponents {
        return NSCalendar.currentCalendar().components([.Day, .Hour, .Minute], fromDate: startDate, toDate: endDate, options: NSCalendarOptions.init(rawValue: 0))
    }
    
    var string:String {
        let (days, hours, minutes) = (self.day, self.hour, self.minute)
        
        if days > 0 {
            return "\(days) day\(days > 1 ? "s" : "")"

        } else if hours > 0 {
            return hours > 0 ? "\(hours) hour\(hours > 1 ? "s" : "")" : ""

        } else if  minutes > 0 {
            return "\(minutes) min"

        } else {
            return ""
        }
    }
}