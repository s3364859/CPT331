//
//  MenuViewController.swift
//  SpatioNews
//
//  Created by Peter Weller on 15/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

/// Populates the side bar menu with quick configuration options, allowing the user to configure what events are shown
class MenuViewController: UITableViewController {
    
    // -----------------------------
    // MARK: Runtime Variables
    // -----------------------------
    lazy var categories = EventCategory.allCategories.sort{ $0.name < $1.name }
    lazy var whitelist = SettingsManager.sharedInstance.whitelist
    
    
    
    // -----------------------------
    // MARK: Main Logic
    // -----------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Hide extra separators
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    
    
    // -----------------------------
    // MARK: Table view data source
    // -----------------------------
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Event Categories"
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }

    
    /// Instantiates a table view cell for the respective event category
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("categoryCell", forIndexPath: indexPath) as! CategoryListCell
        let category = self.categories[indexPath.row]
        
        // If an event category is in the whitelist, make it appear selected
        if let categories = self.whitelist where categories.contains(category) {
            self.tableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: UITableViewScrollPosition.Middle)
        } else {
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        
        cell.category = category
        cell.update()
        
        return cell
    }
    
    
    /// Responds to an event category being selected, adding it to the whitelist
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! CategoryListCell
        if let category = cell.category {
            SettingsManager.sharedInstance.addWhitelistCategory(category)
        }
    }
    
    
    /// Responds to an event category being deselected, removing it from the whitelist
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! CategoryListCell
        if let category = cell.category {
            SettingsManager.sharedInstance.removeWhitelistCategory(category)
        }
    }
}
