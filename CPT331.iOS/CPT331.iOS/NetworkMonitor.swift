//
//  NetworkMonitor.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 4/11/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation
import ReachabilitySwift

class NetworkMonitor {
    
    static let sharedInstance = NetworkMonitor()
    
    private var monitor: Reachability?
    
    /// Whether or not the internet is reachable
    var reachable:Bool {
        if monitor?.currentReachabilityStatus != Reachability.NetworkStatus.NotReachable {
            return true
        } else {
            return false
        }
    }
    
    
    private init() {
        do {
            self.monitor = try Reachability(hostname: ConfigManager.sharedInstance.networkMonitorHostname)
            self.monitor?.whenReachable = self.networkBecameReachable(_:)
            self.monitor?.whenUnreachable = self.networkBecameUnreachable(_:)
            
        } catch _ {
            print("Failed to setup network monitor")
        }
    }
    
    func start() {
        print("--- start notifier")
        do {
            try monitor?.startNotifier()
        } catch {
            print("Unable to start reachability notifier")
        }
    }
    
    func stop() {
        print("--- stop notifier")
        monitor?.stopNotifier()
    }
    
    
    
    // -----------------------------
    // MARK: Responders
    // -----------------------------
    
    /**
        Fired when the network connection became reachable
     
        - Note: this will only be fired while the network is being monitored
     */
    func networkBecameReachable(reachability:Reachability) {
        print("Network is now reachable")
    }
    
    
    /**
        Fired when the network connection became unreachable. Shows network error message.
     
        - Note: this will only be fired while the network is being monitored
     */
    func networkBecameUnreachable(reachability:Reachability) {
        print("Network is no longer reachable")
        
        // Only present view controller if an alert view isnt already presented (prevents stacking)
        guard let topViewController = UIApplication.topViewController() where !(topViewController is UIAlertController) else {
            return
        }
        
        let alert = UIAlertController(title: "Network Error", message: "An internet connection is required to use EventGuardian.", preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertActionStyle.Default, handler: nil))
        topViewController.presentViewController(alert, animated: true, completion: nil)
    }
}