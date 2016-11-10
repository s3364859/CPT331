//
//  SettingsManager
//  CPT331.iOS
//
//  Created by Peter Weller on 20/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation

typealias EventCategoryWhitelist = [EventCategory]

/// Manages the persistence and retrieval of user settings
class SettingsManager {
    
    static let sharedInstance = SettingsManager()
    
    /// Key used for NSNotficationCenter
    static let whitelistChangedNotification = "WhitelistUpdated"
    
    /// Shared defaults object
    private let settings = NSUserDefaults.standardUserDefaults()
    
    /// The keys used to store data in NSUserDefaults (read-only)
    private let keys = (
        whitelist: "eventCategoryWhitelist",
        searchRadius: "eventSearchRadius",
        launchedBefore: "launchedBefore"
    )
    
    
    /// Singleton Initializer. Initializes settings with default values if not already defined.
    private init() {
        if self.whitelist == nil {
            self._whitelist = EventCategory.allCategories
        }
    }
    
    
    
    // -----------------------------
    // MARK: Whitelist
    // -----------------------------
    /// Retrieves current event category whitelist from NSUserDefaults
    private var _whitelist:EventCategoryWhitelist? {
        get {
            if let rawValues = settings.arrayForKey(keys.whitelist) as? [Int] {
                var categories = EventCategoryWhitelist()
                
                for rawValue in rawValues {
                    if let category = EventCategory(rawValue: rawValue) {
                        categories.append(category)
                    }
                }
                
                return categories
                
            } else {
                return nil
            }
        }
        
        set {
            let rawValues = newValue != nil ? newValue!.map({$0.hashValue}) : []
            settings.setObject(rawValues, forKey: keys.whitelist)
            
            // App-wide broadcast
            NSNotificationCenter.defaultCenter().postNotificationName(SettingsManager.whitelistChangedNotification, object: nil)
        }
    }
    
    var whitelist:EventCategoryWhitelist? {
        get {
            return self._whitelist
        }
    }
    
    
    /// Adds a category to the whitelist
    func addWhitelistCategory(category:EventCategory) {
        if let current = self.whitelist where !current.contains(category) {
            var modified = current
            modified.append(category)
            self._whitelist = modified
        }
    }
    
    
    /// Removes a category from the whitelist
    func removeWhitelistCategory(category:EventCategory) {
        if let current = self.whitelist, let index = current.indexOf(category) {
            var modified = current
            modified.removeAtIndex(index)
            self._whitelist = modified
        }
    }
    
    
    
    // -----------------------------
    // MARK: Search Radius
    // -----------------------------
    var searchRadius:Double? {
        get {
            if let settingsValue = settings.valueForKey(keys.searchRadius) as? Double {
                return settingsValue
            } else {
                let defaultValue = ConfigManager.sharedInstance.defaultSearchRadius
                return defaultValue
            }
        }
        
        set {
            if newValue != nil {
                settings.setDouble(newValue!, forKey: keys.searchRadius)
            }
        }
    }
    
    var launchedBefore:Bool {
        get {
            return settings.boolForKey(keys.launchedBefore)
        }
        
        set {
            settings.setBool(newValue, forKey: keys.launchedBefore)
        }
    }
}