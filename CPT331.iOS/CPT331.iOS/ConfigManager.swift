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
            return valueFor(.API, "EventGuardian")
        }
    }
    
    var darkSkyAPI:String {
        get {
            return valueFor(.API, "DarkSky")
        }
    }
    
    var networkMonitorHostname:String {
        get {
            return valueFor(.NetworkMonitor, "HostName")
        }
    }
    
    var networkMonitorDelay:Double {
        get {
            return valueFor(.NetworkMonitor, "Delay")
        }
    }
    
    var forceTutorialMode:Bool {
        get {
            return valueFor(.Launch, "ForceTutorialMode")
        }
    }
    
    var defaultSearchRadius:Double {
        get {
            return valueFor(.Search, "DefaultSearchRadius")
        }
    }
    
    
    var minSearchRadius:Double {
        get {
            return valueFor(.Search, "MinSearchRadius")
        }
    }
    
    var maxSearchRadius:Double {
        get {
            return valueFor(.Search, "MaxSearchRadius")
        }
    }
    
    private func valueFor(parentKey:ParentKey, _ childKey:String) -> AnyObject {
        return dictionary[parentKey.rawValue]!.valueForKey(childKey)
    }
}