//
//  NSDate.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 21/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation

extension NSDate {
    
    func toString(format:String, locale:NSLocale?=nil) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = locale
        return dateFormatter.stringFromDate(self)
    }
    
    class func fromString(dateString:String, format:String) -> NSDate? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.dateFromString(dateString)
    }
    
    
    // ISO8601 Support
    func toISO8601() -> String {
        return self.toString("yyyy-MM-dd'T'HH:mm:ss", locale: NSLocale(localeIdentifier: "en_US_POSIX"))
    }
    
    class func fromISO8601(dateString:String) -> NSDate? {
        return NSDate.fromString(dateString, format: "yyyy-MM-dd'T'HH:mm:ss")
    }
}