//
//  NSMutableAttributedString.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 3/11/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    
    /**
        Mutates string to set font weight of substring as bold
     
        - Parameters:
            - bold string: the substring to be bolded
            - font size: font size for the bolded substring
    */
    func makeBold(boldString:String, withFontSize fontSize:CGFloat) {
        let range = (self.string as NSString).rangeOfString(boldString)
        self.addAttribute(NSFontAttributeName, value: UIFont.boldSystemFontOfSize(fontSize), range: range)
    }
}