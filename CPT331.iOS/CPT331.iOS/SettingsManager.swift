//
//  SettingsManager
//  CPT331.iOS
//
//  Created by Peter Weller on 20/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation

typealias EventCategoryWhitelist = [EventCategory]

class SettingsManager {
    static let sharedInstance = SettingsManager()
    
    private let defaults = NSUserDefaults.standardUserDefaults()
    private let whitelistKey = "eventCategoryWhitelist"
    
    // Prevent external initialization
    private init() {
        if self.whitelist == nil {
            self.updateWhitelistCategories(EventCategory.allCategories)
        }
    }
    
    var whitelist:EventCategoryWhitelist? {
        var stored = EventCategoryWhitelist()
        
        if let rawValues = defaults.arrayForKey(whitelistKey) as? [Int] {
            for rawValue in rawValues {
                
                if let category = EventCategory(rawValue: rawValue) {
                    stored.append(category)
                }
            }
        }
        
        return stored
    }
    
    func addWhitelistCategory(category:EventCategory) {
        if let current = self.whitelist where !current.contains(category) {
            var modified = current
            modified.append(category)
            self.updateWhitelistCategories(modified)
        }
    }
    
    func removeWhitelistCategory(category:EventCategory) {
        if let current = self.whitelist, let index = current.indexOf(category) {
            var modified = current
            modified.removeAtIndex(index)
            self.updateWhitelistCategories(modified)
        }
    }
    
    private func updateWhitelistCategories(categories:EventCategoryWhitelist) {
        let rawValues = categories.map({$0.hashValue})
        defaults.setObject(rawValues, forKey: whitelistKey)
        
        // App-wide broadcast
        NSNotificationCenter.defaultCenter().postNotificationName("WhitelistUpdated", object: nil)
    }
}