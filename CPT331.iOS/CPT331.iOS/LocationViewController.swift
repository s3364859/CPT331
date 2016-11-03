//
//  LocationViewController.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 7/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

/// Parent class for displaying location data, intended to be subclassed.
class LocationViewController: UIViewController {
    
    // -----------------------------
    // MARK: Runtime Variables
    // -----------------------------
    
    // Allow the location to be manually set.
    // If not set, fetch it from the tab bar controller
    private var _location:Location?
    var location:Location {
        set {
            self._location = newValue
        }
        
        get {
            if let location = self._location {
                return location
            } else {
                return (self.tabBarController as! LocationTabBarController).location
            }
        }
    }
    
    
    
    // -----------------------------
    // MARK: Main Logic
    // -----------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = self.location.name
    }
    
    /// Overrides the default functionality to ensure the tab bar is visible upon returning to this view
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
}
