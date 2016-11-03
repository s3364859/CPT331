//
//  UILabel.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 3/11/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    
    /**
        Mutates label text to set fontweight of substring(s) as bold
     
        - Note: the substring(s) will use the original fontsize
     
        - Parameters:
            - string(s): the substring(s) to be bolded
    */
    func makeBold(boldStrings:String...) {
        if let mutableString = self.attributedText?.mutableCopy() as? NSMutableAttributedString {
            for boldString in boldStrings {
                mutableString.makeBold(boldString, withFontSize: self.font.pointSize)
            }
            
            self.attributedText = mutableString
        }
    }
}