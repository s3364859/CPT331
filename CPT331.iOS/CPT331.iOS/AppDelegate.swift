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
    // MARK: Constants
    // -----------------------------
    let networkMonitorDelay:Double = 3
    let networkMonitorHostname:String = "google.com"
    
    
    
    // -----------------------------
    // MARK: Runtime Variables
    // -----------------------------
    var window: UIWindow?
    var networkMonitor: Reachability?

    
    
    // -----------------------------
    // MARK: UIApplicationDelegate
    // -----------------------------
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.applyGlobalStyling()
        
        // Run tutorial mode on first launch
        // NSUserDefaults.standardUserDefaults().boolForKey("launchedBefore") == false
        if true {
            self.setRootViewController(withIdentifier: "tutorialView", animated: false)
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "launchedBefore")
        } else {
            print("Previously launched, skipping tutorial")
        }
        
        dispatch_after(UInt64(self.networkMonitorDelay * Double(NSEC_PER_SEC)), dispatch_get_main_queue()) {
            self.initNetworkMonitor()
        }
        
        return true
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        self.stopNetworkMonitor()
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        self.startNetworkMonitor()
    }
    
    
    // -----------------------------
    // MARK: Network Monitor
    // -----------------------------
    func initNetworkMonitor() {
        do {
            let reachability = try Reachability(hostname: self.networkMonitorHostname)
            self.networkMonitor = reachability
            self.networkMonitor?.whenReachable = self.networkReachable(_:)
            self.networkMonitor?.whenUnreachable = self.networkUnreachable(_:)
            self.startNetworkMonitor()
            
        } catch _ {
            print("Failed to setup reachability")
        }
    }
    
    func startNetworkMonitor() {
        print("--- start notifier")
        do {
            try networkMonitor?.startNotifier()
        } catch {
            print("Unable to start reachability notifier")
        }
    }
    
    func stopNetworkMonitor() {
        print("--- stop notifier")
        networkMonitor?.stopNotifier()
    }
    
    func networkReachable(reachability:Reachability) {
        print("Network is now reachable")
    }
    
    func networkUnreachable(reachability:Reachability) {
        print("Network is no longer reachable")
        
        // Only present view controller if an alert view isnt already presented (prevents stacking)
        guard let topViewController = UIApplication.topViewController() where !(topViewController is UIAlertController) else {
            return
        }
        
        let alert = UIAlertController(title: "Network Error", message: "An internet connection is required to use EventGuardian.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        topViewController.presentViewController(alert, animated: true, completion: nil)
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
    
    func setRootViewController(withIdentifier identifier:String, animated:Bool) {
        guard let viewController = self.window?.rootViewController?.storyboard?.instantiateViewControllerWithIdentifier(identifier) else {
            return
        }
        
        if animated {
            let snapshot:UIView = (self.window?.snapshotViewAfterScreenUpdates(true))!
            viewController.view.addSubview(snapshot);
            self.window?.rootViewController = viewController
            
            UIView.animateWithDuration(0.3, animations:
                {() in
                    snapshot.layer.opacity = 0
                }, completion: {
                    (value: Bool) in
                    snapshot.removeFromSuperview()
                }
            )
            
        } else {
            self.window?.rootViewController = viewController
        }
    }
}

