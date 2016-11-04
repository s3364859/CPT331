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
    // MARK: Constants
    // -----------------------------
    enum MenuSection:Int {
        case Configuration=0, Category
        
        static var all:[MenuSection] {
            return [Configuration, Category]
        }
        
        var name:String {
            switch self {
            case .Configuration:
                return "Configuration"
            case .Category:
                return "Event Categories"
            }
        }
        
        var rowHeight:CGFloat {
            switch self {
            case .Configuration:
                return 70
            case .Category:
                return 50
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
    
    func searchRadiusChanged(newValue:Double) {
        print("New search radius: \(newValue)")
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
            let radiusCell = tableView.dequeueReusableCellWithIdentifier("sliderCell", forIndexPath: indexPath) as! SliderCell
            cell = radiusCell
            
            radiusCell.titleLabel.text = "Event Search Radius"
            radiusCell.unitsLabel.text = "km"
            radiusCell.onSliderChange = self.searchRadiusChanged
            
        case .Category:
            let categoryCell = tableView.dequeueReusableCellWithIdentifier("categoryCell", forIndexPath: indexPath) as! CategoryListCell
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
        }
        
        return cell
    }
    
    
    /// Responds to an event category being selected, adding it to the whitelist
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        if MenuSection(rawValue: indexPath.section)! == .Category, let category = (tableView.cellForRowAtIndexPath(indexPath) as? CategoryListCell)?.category {
            SettingsManager.sharedInstance.addWhitelistCategory(category)
        }
    }
    
    
    /// Responds to an event category being deselected, removing it from the whitelist
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if MenuSection(rawValue: indexPath.section)! == .Category, let category = (tableView.cellForRowAtIndexPath(indexPath) as? CategoryListCell)?.category {
            SettingsManager.sharedInstance.removeWhitelistCategory(category)
        }
    }
}
