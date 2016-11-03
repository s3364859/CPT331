//
//  AppDelegate.swift
//  SpatioNews
//
//  Created by Peter Weller on 15/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        self.applyGlobalStyling()
        
        // Run tutorial mode on first launch
        if NSUserDefaults.standardUserDefaults().boolForKey("launchedBefore") == false {
            self.setRootViewController(withIdentifier: "tutorialView", animated: false)
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "launchedBefore")
        } else {
            print("Previously launched, skipping tutorial")
        }
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
    }

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

