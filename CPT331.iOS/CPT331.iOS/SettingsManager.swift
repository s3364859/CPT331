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
    private let defaults = NSUserDefaults.standardUserDefaults()
    private let whitelistKey = "eventCategoryWhitelist"
    
    
    
    /// Initializes settings with default values if not already defined.
    private init() {
        if self.whitelist == nil {
            self.updateWhitelistCategories(EventCategory.allCategories)
        }
    }
    
    
    /// Retrieves current event category whitelist from NSUserDefaults
    var whitelist:EventCategoryWhitelist? {
        get {
            if let rawValues = defaults.arrayForKey(whitelistKey) as? [Int] {
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
    }
    
    
    /// Adds a category to the whitelist
    func addWhitelistCategory(category:EventCategory) {
        if let current = self.whitelist where !current.contains(category) {
            var modified = current
            modified.append(category)
            self.updateWhitelistCategories(modified)
        }
    }
    
    
    /// Removes a category from the whitelist
    func removeWhitelistCategory(category:EventCategory) {
        if let current = self.whitelist, let index = current.indexOf(category) {
            var modified = current
            modified.removeAtIndex(index)
            self.updateWhitelistCategories(modified)
        }
    }
    
    
    /// Updates the persisted whitelist to reflect the provided one
    private func updateWhitelistCategories(categories:EventCategoryWhitelist) {
        let rawValues = categories.map({$0.hashValue})
        defaults.setObject(rawValues, forKey: whitelistKey)
        
        // App-wide broadcast
        NSNotificationCenter.defaultCenter().postNotificationName("WhitelistUpdated", object: nil)
    }
}