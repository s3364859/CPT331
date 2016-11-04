//
//  ConfigManager.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 3/11/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation

/// Convenience wrapper for Config.plist
class ConfigManager {
    static let sharedInstance = ConfigManager()
    
    private let dictionary: NSDictionary!
    
    private init() {
        let plistPath = NSBundle.mainBundle().pathForResource("Config", ofType: "plist")!
        self.dictionary = NSDictionary(contentsOfFile: plistPath)
    }
    
    var eventGuardianAPI:String {
        get {
            return dictionary["API"]!.valueForKey("EventGuardian") as! String
        }
    }
    
    var darkSkyAPI:String {
        get {
            return dictionary["API"]!.valueForKey("DarkSky") as! String
        }
    }
    
    var networkMonitorHostname:String {
        get {
            return dictionary["NetworkMonitor"]!.valueForKey("Hostname") as! String
        }
    }
    
    var networkMonitorDelay:Double {
        get {
            return dictionary["NetworkMonitor"]!.valueForKey("Delay") as! Double
        }
    }
    
    var forceTutorialMode:Bool {
        get {
            return dictionary["Launch"]!.valueForKey("ForceTutorialMode") as! Bool
        }
    }
    
    var defaultSearchRadius:Double {
        return dictionary["Search"]!.valueForKey("DefaultSearchRadius") as! Double
    }
    
    
    var minSearchRadius:Double {
        return dictionary["Search"]!.valueForKey("MinSearchRadius") as! Double
    }
    
    var maxSearchRadius:Double {
        return dictionary["Search"]!.valueForKey("MaxSearchRadius") as! Double
    }
}