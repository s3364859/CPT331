//
//  UIApplication.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 4/11/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation
import UIKit
import ReachabilitySwift

extension UIApplication {
    
    static var appDelegate:AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
    
    static var tutorialStoryboardIdentifier:String {
        get {
            return "tutorialView"
        }
    }
    
    
    /**
        Retrieves the topmost view controller
     
        [Third party code](http://stackoverflow.com/a/30572389) by Stack Overflow user: gutenmorgenuhu.
    */
    class func topViewController(base: UIViewController? = appDelegate.window?.rootViewController) -> UIViewController? {
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
    
    
    /**
        Sets the root view controller using a string identifier for the Main Storyboard
     
        - Parameters:
            - identifier: the string identifier for the view controller
            - animated: TRUE if the transition whould be animated (opacity)
    */
    class func setRootViewController(identifier:String, animated:Bool) {
        guard let window = appDelegate.window else {
            return
        }
        
        guard let viewController = appDelegate.window?.rootViewController?.storyboard?.instantiateViewControllerWithIdentifier(identifier) else {
            return
        }
        
        if animated {
            let snapshot:UIView = (window.snapshotViewAfterScreenUpdates(true))
            viewController.view.addSubview(snapshot);
            window.rootViewController = viewController
            
            UIView.animateWithDuration(0.3, animations:
                {() in
                    snapshot.layer.opacity = 0
                }, completion: {
                    (value: Bool) in
                    snapshot.removeFromSuperview()
                }
            )
            
        } else {
            window.rootViewController = viewController
        }
    }
}