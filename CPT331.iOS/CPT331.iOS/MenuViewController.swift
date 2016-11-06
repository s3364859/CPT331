//
//  MenuViewController.swift
//  SpatioNews
//
//  Created by Peter Weller on 15/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit
import SideMenu
import EZAlertController

/// Populates the side bar menu with quick configuration options, allowing the user to configure what events are shown
class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // -----------------------------
    // MARK: Constants
    // -----------------------------
    enum MenuSection:Int {
        case Configuration=0, Category, Other
        
        static var all:[MenuSection] {
            return [Configuration, Category, Other]
        }
        
        var name:String? {
            switch self {
            case .Configuration:
                return "Configuration"
            case .Category:
                return "Event Categories"
            case .Other:
                return "EventGuardian"
            }
        }
        
        var rowHeight:CGFloat {
            switch self {
            case .Configuration:
                return 75
            case .Category:
                return 45
            case .Other:
                return 45
            }
        }
    }
    
    
    
    // -----------------------------
    // MARK: Runtime Variables
    // -----------------------------
    lazy var categories = EventCategory.allCategories.sort{ $0.name < $1.name }
    lazy var whitelist = SettingsManager.sharedInstance.whitelist
    
    
    
    // -----------------------------
    // MARK: Storyboard References
    // -----------------------------
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var creditsView: UIView!
    @IBOutlet weak var helpView: UIView!
    
    
    
    // -----------------------------
    // MARK: Main Logic
    // -----------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        SideMenuManager.menuFadeStatusBar = false
        
        // Setup table
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        self.tableView.contentInset = UIEdgeInsetsZero
    }
    
    
    /**
        Handles view controller transitions. If the destination view controller is a modal view controller, the respectivfe subview controller will also be initialized.

        - Parameters:
            - segue: the segue object containing information about view controllers involved in segue
            - sender: the object to be displayed in the view
     */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "showCreditsView", let modalViewController = segue.destinationViewController as? ModalViewController {
            if let controller = self.storyboard?.instantiateViewControllerWithIdentifier("creditsNavigationController") {
                modalViewController.subViewController = controller
            }
        }
    }
    
    
    
    func searchRadiusChanged(newValue:Double) {
        SettingsManager.sharedInstance.searchRadius = newValue
    }

    
    
    // -----------------------------
    // MARK: Table view data source
    // -----------------------------
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return MenuSection.all.count
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return MenuSection(rawValue: section)?.name
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch MenuSection(rawValue: section)! {
        case .Configuration:
            return 1
        case .Category:
            return self.categories.count
        case .Other:
            return 2
        }
    }

    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return MenuSection(rawValue: indexPath.section)!.rowHeight
    }
    
    /// Instantiates a table view cell for the respective event category
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UITableViewCell!
        
        switch MenuSection(rawValue: indexPath.section)! {
        case .Configuration:
            let radiusCell = tableView.dequeueReusableCellWithIdentifier("sliderCell", forIndexPath: indexPath) as! MenuSliderCell
            cell = radiusCell
            
            radiusCell.titleLabel.text = "Search Radius"
            radiusCell.unitsLabel.text = "km"
            
            radiusCell.slider.value = Float(SettingsManager.sharedInstance.searchRadius!)
            radiusCell.slider.minimumValue = Float(ConfigManager.sharedInstance.minSearchRadius)
            radiusCell.slider.maximumValue = Float(ConfigManager.sharedInstance.maxSearchRadius)
            radiusCell.updateValueLabel()
            radiusCell.onSliderChange = self.searchRadiusChanged
            
        case .Category:
            let categoryCell = tableView.dequeueReusableCellWithIdentifier("categoryCell", forIndexPath: indexPath) as! MenuCategoryCell
            cell = categoryCell
            
            let category = self.categories[indexPath.row]
            
            // If an event category is in the whitelist, make it appear selected
            if let categories = self.whitelist where categories.contains(category) {
                self.tableView.selectRowAtIndexPath(indexPath, animated: true, scrollPosition: UITableViewScrollPosition.Middle)
            } else {
                self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
            }
            
            categoryCell.category = category
            categoryCell.update()
            
        case .Other:
            let disclosureCell = tableView.dequeueReusableCellWithIdentifier("disclosureCell", forIndexPath: indexPath) as! MenuDisclosureCell
            cell = disclosureCell
            
            if indexPath.row == 0 {
                disclosureCell.titleLabel.text = "Credits"
            } else if indexPath.row == 1 {
                disclosureCell.titleLabel.text = "Help"
            }
        }
        
        return cell
    }
    
    
    /// Responds to an event category being selected, adding it to the whitelist
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        if MenuSection(rawValue: indexPath.section)! == .Category, let category = (tableView.cellForRowAtIndexPath(indexPath) as? MenuCategoryCell)?.category {
            SettingsManager.sharedInstance.addWhitelistCategory(category)
            
        } else if MenuSection(rawValue: indexPath.section)! == .Other {
            // Prevent row from being in selected state
            tableView.deselectRowAtIndexPath(indexPath, animated: false)
            
            if indexPath.row == 0 {
                self.performSegueWithIdentifier("showCreditsView", sender: nil)
            } else if indexPath.row == 1 {
                self.performSegueWithIdentifier("showTutorial", sender: nil)
            }
        }
    }
    
    /// Responds to an event category being deselected, removing it from the whitelist
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if MenuSection(rawValue: indexPath.section)! == .Category, let category = (tableView.cellForRowAtIndexPath(indexPath) as? MenuCategoryCell)?.category {
            SettingsManager.sharedInstance.removeWhitelistCategory(category)
        }
    }
}