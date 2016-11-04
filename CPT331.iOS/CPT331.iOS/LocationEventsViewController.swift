//
//  LocationEventsViewController.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 20/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

/// Handles retrieving and displaying events surrounding a particular location
class LocationEventsViewController: LocationViewController, UITableViewDataSource, UITableViewDelegate, EventsViewModelDelegate {
    
    // -----------------------------
    // MARK: Constants
    // -----------------------------
    let rowHeight:CGFloat = 54
    
    
    
    // -----------------------------
    // MARK: Runtime Variables
    // -----------------------------
    var viewModel:LocationViewModel!
    var indicator:UIActivityIndicatorView?
    var navIndicator:UIBarButtonItem?
    
    
    
    // -----------------------------
    // MARK: Storyboard References
    // -----------------------------
    @IBOutlet weak var tableView: UITableView!
    
    
    
    // -----------------------------
    // MARK: Main Logic
    // -----------------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        // View Model
        self.viewModel = LocationViewModel(location: self.location)
        self.viewModel.delegate = self

        // Table View
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.backgroundColor = .clearColor()
        self.tableView.tableFooterView = UIView()
        self.tableView.rowHeight = self.rowHeight
        
        
        if NetworkMonitor.sharedInstance.reachable {
            // Loading Indicators
            self.indicator = self.view.showLoadingIndicator()
            self.navIndicator = UIBarButtonItem(customView:
                UIView(frame: CGRectMake(0, 0, 30, 30)).showLoadingIndicator(style: .White)
            )
            
            // Populate table with data
            self.viewModel.loadEvents(fromCache: true, fromAPI: true)
            
        } else {
            self.view.showNetworkMissingIndicator()
        }
    }
    
    
    /**
        Overrides default functionality so that the tables alpha can also be animated. This is necessary because of the clear background.
        Under normal circumstances, it is expected that the pushed views background will cover the current view
     
        - Parameters
            - animated: whether or not the transition is being animated
    */
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Animate table alpha so it can transition smoothly to subview, this is necessary because a clear color has been specified.
        // Under normal circumstances, it is expected that the pushed view's background will cover the current view.
        if animated {
            UIView.animateWithDuration(0.25, animations: {
                self.tableView.alpha = 0
            })
        }
    }
    
    
    /// Overrides the default functionality so the table alpha can be restored, ensuring it is visible again
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.alpha = 1
    }
    
    
    
    // -----------------------------
    // MARK: Data Display
    // -----------------------------
    
    /// Updates the view to reflect the currently stored data
    func showData() {
        // Execute table reload on main thread
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })

        // On first call, move the loading indicator to the nav bar
        if self.indicator != nil && self.navIndicator != nil {
            
            if self.viewModel.sections?.count > 0 {
                self.indicator?.removeFromSuperview()
                self.indicator = nil
                self.navigationItem.rightBarButtonItem = self.navIndicator
            } else {
                self.navIndicator = nil
            }
        
        // Remove all indicators on subsequent calls
        } else {
            self.indicator?.removeFromSuperview()
            self.navIndicator = nil
            self.navigationItem.rightBarButtonItem = nil
        }
    }


    
    
    
    // -----------------------------
    // MARK: Table view data source
    // -----------------------------
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let sections = self.viewModel.sections {
            return sections.count
        } else {
            return 0
        }
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return self.viewModel.sections?[section].type.name
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let section = self.viewModel.sections?[section] {
            return section.events.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as! EventsListCell
        
        if let event = self.viewModel.sections?[indexPath.section].events[indexPath.row]  {
            cell.event = event
            cell.update()
        }
        
        return cell
    }
    
    /// Transitions the view to the selected event
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        // Manually segue to single event view
        if let cell = tableView.cellForRowAtIndexPath(indexPath) as? EventsListCell {
            if let controller = self.storyboard?.instantiateViewControllerWithIdentifier("eventViewController") as? EventViewController {
                controller.event = cell.event
                self.navigationController?.pushViewController(controller, animated: true)
            }
        }
    }
}
