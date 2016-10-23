//
//  NSDate.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 21/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation

extension NSDate {
    
    /**
        Formats the date/time as a string using the provided formatting string.
     
        - Note: Refer to [Date Field Symbol Table](http://www.unicode.org/reports/tr35/tr35-31/tr35-dates.html#Date_Field_Symbol_Table) for information on how to construct the format string.
     
        - Parameters:
            - format: the format for how the date/time should be represented as a string
            - locale: locale for linguistic, cultural, and technological conventions and standards (Optional)
        
        - Returns: a formatted string
    */
    func toString(format:String, locale:NSLocale?=nil) -> String {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = locale
        return dateFormatter.stringFromDate(self)
    }
    
    
    /**
        Converts a datetime string into a NSDate object using the provided formatting string.
     
        - Note: Refer to [Date Field Symbol Table](http://www.unicode.org/reports/tr35/tr35-31/tr35-dates.html#Date_Field_Symbol_Table) for information on how to construct the format string.
     
        - Parameters:
            - datetime string: the raw datetime string to be parsed
            - format: the format for how the date/time should be interpreted
     
     - Returns: a NSDate object if successfully converted
     */
    class func fromString(dateString:String, format:String) -> NSDate? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.dateFromString(dateString)
    }
    
    
    /// Returns an ISO 8601 formatted string of the NSDate object
    func toISO8601() -> String {
        return self.toString("yyyy-MM-dd'T'HH:mm:ss", locale: NSLocale(localeIdentifier: "en_US_POSIX"))
    }
    
    
    /// Attempts to convert the provided ISO 8601 date string to a NSDate object
    class func fromISO8601(dateString:String) -> NSDate? {
        return NSDate.fromString(dateString, format: "yyyy-MM-dd'T'HH:mm:ss")
    }
}