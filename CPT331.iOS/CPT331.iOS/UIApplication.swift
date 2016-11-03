//
//  UIApplication.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 4/11/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation
import UIKit

extension UIApplication {
    
    /**
        Retrieves the topmost view controller
     
        [Third party code](http://stackoverflow.com/a/30572389) by Stack Overflow user: gutenmorgenuhu.
    */
    class func topViewController(base: UIViewController? = (UIApplication.sharedApplication().delegate as! AppDelegate).window?.rootViewController) -> UIViewController? {
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
}