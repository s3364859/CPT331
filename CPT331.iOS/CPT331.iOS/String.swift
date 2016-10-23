//
//  String.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 20/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation

extension String {
    
    /// The length of the string (character count)
    var length: Int {
        get {
            return self.characters.count
        }
    }
    
    
    /**
        Encodes the string as Base64
     
        [Third party code](http://stackoverflow.com/a/32512122) by Stack Overflow user: PiXeL16, 2015.
     
        - Returns: Base64 encoded string
    */
    func toBase64() -> String {
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)
        return data!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
    }
    
    
    /**
        Convenience function for testing to see if the string matches the provided regular expression pattern.
        
        [Third party code](http://stackoverflow.com/a/34522960) by Stack Overflow user: solos, 2016.
     
        - Parameters:
            - pattern: the regular expression pattern to test
     
        - Returns: TRUE if the pattern matches, otherwise FALSE
    */
    func matchPattern(regexPattern:String)->Bool {
        
        var isMatch:Bool = false
        do {
            let regex = try NSRegularExpression(pattern: regexPattern, options: [.CaseInsensitive])
            let result = regex.firstMatchInString(self, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, characters.count))
            
            if (result != nil)
            {
                isMatch = true
            }
        }
        catch {
            isMatch = false
        }
        return isMatch
    }
}