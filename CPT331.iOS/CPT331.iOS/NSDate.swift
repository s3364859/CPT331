//
//  NSDate.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 21/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation

extension NSDate {
    
    func asISO8601() -> String {
        let dateFormatter = NSDateFormatter()
        let enUSPosixLocale = NSLocale(localeIdentifier: "en_US_POSIX")
        dateFormatter.locale = enUSPosixLocale
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        return dateFormatter.stringFromDate(self)
    }
}