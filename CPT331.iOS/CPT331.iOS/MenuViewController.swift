//
//  MenuViewController.swift
//  SpatioNews
//
//  Created by Peter Weller on 15/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {

    let categories = EventCategory.allCategories.sort{ $0.name < $1.name }
    var whitelist:[EventCategory]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.whitelist = SettingsManager.sharedInstance.whitelist
        
        // Hide extra separators
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Event Categories"
        }
        
        return nil
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("categoryCell", forIndexPath: indexPath) as! CategoryListCell
        let category = self.categories[indexPath.row]
        
        if let categories = self.whitelist where categories.contains(category) {
            self.tableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: UITableViewScrollPosition.Middle)
        } else {
            self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        }
        
        cell.category = category
        cell.update()
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! CategoryListCell
        if let category = cell.category {
            SettingsManager.sharedInstance.addWhitelistCategory(category)
        }
    }
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! CategoryListCell
        if let category = cell.category {
            SettingsManager.sharedInstance.removeWhitelistCategory(category)
        }
    }

}
