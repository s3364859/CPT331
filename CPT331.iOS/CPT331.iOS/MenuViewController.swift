//
//  MenuViewController.swift
//  SpatioNews
//
//  Created by Peter Weller on 15/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

/// Populates the side bar menu with quick configuration options, allowing the user to configure what events are shown
class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // -----------------------------
    // MARK: Runtime Variables
    // -----------------------------
    lazy var categories = EventCategory.allCategories.sort{ $0.name < $1.name }
    lazy var whitelist = SettingsManager.sharedInstance.whitelist
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var helpView: UIView!
    
    
    // -----------------------------
    // MARK: Main Logic
    // -----------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup table
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.contentInset = UIEdgeInsetsZero
        
        // Setup help gesture recognizer
        self.helpView.addGestureRecognizer(
            UITapGestureRecognizer(target: self, action: #selector(self.helpViewTapped))
        )
    }
    
    func helpViewTapped(view:UIView) {
        self.performSegueWithIdentifier("showTutorial", sender: nil)
    }
    
    
    
    // -----------------------------
    // MARK: Table view data source
    // -----------------------------
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Event Categories"
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categories.count
    }

    
    /// Instantiates a table view cell for the respective event category
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
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
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! CategoryListCell
        if let category = cell.category {
            SettingsManager.sharedInstance.addWhitelistCategory(category)
        }
    }
    
    
    /// Responds to an event category being deselected, removing it from the whitelist
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! CategoryListCell
        if let category = cell.category {
            SettingsManager.sharedInstance.removeWhitelistCategory(category)
        }
    }
}
