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
    
    enum ParentKey:String {
        case Search = "Search"
        case Launch = "Launch"
        case NetworkMonitor = "NetworkMonitor"
        case API = "API"
    }
    
    static let sharedInstance = ConfigManager()
    
    private let dictionary: NSDictionary!
    
    private init() {
        let plistPath = NSBundle.mainBundle().pathForResource("Config", ofType: "plist")!
        self.dictionary = NSDictionary(contentsOfFile: plistPath)
    }
    
    var eventGuardianAPI:String {
        get {
            return valueFor(.API, "EventGuardian") as! String
        }
    }
    
    var darkSkyAPI:String {
        get {
            return valueFor(.API, "DarkSky") as! String
        }
    }
    
    var networkMonitorHostname:String {
        get {
            return valueFor(.NetworkMonitor, "Hostname") as! String
        }
    }
    
    var networkMonitorDelay:Double {
        get {
            return valueFor(.NetworkMonitor, "Delay") as! Double
        }
    }
    
    var forceTutorialMode:Bool {
        get {
            return valueFor(.Launch, "ForceTutorialMode") as! Bool
        }
    }
    
    var defaultSearchRadius:Double {
        get {
            return valueFor(.Search, "DefaultSearchRadius") as! Double
        }
    }
    
    
    var minSearchRadius:Double {
        get {
            return valueFor(.Search, "MinSearchRadius") as! Double
        }
    }
    
    var maxSearchRadius:Double {
        get {
            return valueFor(.Search, "MaxSearchRadius") as! Double
        }
    }
    
    private func valueFor(parentKey:ParentKey, _ childKey:String) -> AnyObject! {
        return dictionary[parentKey.rawValue]!.valueForKey(childKey)
    }
}