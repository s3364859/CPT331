//
//  AppDelegate.swift
//  SpatioNews
//
//  Created by Peter Weller on 15/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit
import CoreData
import ReachabilitySwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    // -----------------------------
    // MARK: Runtime Variables
    // -----------------------------
    var window: UIWindow?
    
    
    
    // -----------------------------
    // MARK: UIApplicationDelegate
    // -----------------------------
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.applyGlobalStyling()
        
        // Run tutorial mode on first launch
        if NSUserDefaults.standardUserDefaults().boolForKey("launchedBefore") == false {
            UIApplication.setRootViewController("tutorialView", animated: false)
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "launchedBefore")
        } else {
            print("Previously launched, skipping tutorial")
        }
        
        // Initialize monitor after delay
        let delay = ConfigManager.sharedInstance.networkMonitorDelay
        dispatch_after(UInt64(delay * Double(NSEC_PER_SEC)), dispatch_get_main_queue()) {
            NetworkMonitor.sharedInstance.start()
        }
        
        return true
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        NetworkMonitor.sharedInstance.stop()
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        NetworkMonitor.sharedInstance.start()
    }
    
    
    
    // -----------------------------
    // MARK: Helpers
    // -----------------------------
    func applyGlobalStyling() {
        let textHightlightColor     = UIColor(red: 58/255, green: 154/255, blue: 215/255, alpha: 1)
        
        let navBarColor             = UIColor(red: 61/255, green: 89/255, blue: 118/255, alpha: 1)
        let navTextColor            = UIColor.whiteColor()
        
        let tableHeaderBackgroundColor  = UIColor(red: 116/255, green: 160/255, blue: 203/255, alpha: 1.0)
        let tableHeaderTextcolor        = UIColor.whiteColor()
        let tableHeaderFont             = UIFont(name: "HelveticaNeue-Medium", size: 14)
        
        // Nav bar styling
        let navigation = UINavigationBar.appearance()
        navigation.barTintColor = navBarColor
        navigation.tintColor = navTextColor
        navigation.titleTextAttributes = [NSForegroundColorAttributeName: navTextColor]
        
        // Text highlight styling
        UITextField.appearance().tintColor = textHightlightColor
        
        // Table Header Background Styling
        UITableViewHeaderFooterView.appearance().tintColor = tableHeaderBackgroundColor
        
        // Table Header Text Styling
        let tableHeaderText = UILabel.appearanceWhenContainedInInstancesOfClasses([UITableViewHeaderFooterView.self])
        tableHeaderText.textColor = tableHeaderTextcolor
        tableHeaderText.font = tableHeaderFont
    }
}

