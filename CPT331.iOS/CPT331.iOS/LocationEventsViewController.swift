//
//  LocationEventsViewController.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 20/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

class LocationEventsViewController: LocationViewController, UITableViewDataSource, UITableViewDelegate, EventsViewModelDelegate {

    let ROW_HEIGHT:CGFloat = 54
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel:LocationViewModel!

    var indicator:UIActivityIndicatorView?
    var navIndicator:UIBarButtonItem?

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
        
        // Loading Indicators
        self.indicator = self.view.showLoadingIndicator()
        self.navIndicator = UIBarButtonItem(customView:
            UIView(frame: CGRectMake(0, 0, 30, 30)).showLoadingIndicator(style: .White)
        )

        // Populate table with data
        self.viewModel.loadEvents(fromCache: true, fromAPI: true)
    }
    
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Restore the table alpha so that it is visible
        self.tableView.alpha = 1
    }


    
    func update() {
        // Execute table reload on main thread
        dispatch_async(dispatch_get_main_queue(), {
            self.tableView.reloadData()
        })

        // First call
        // Assumption: 2 calls will be made
        // TODO: make this logic more robust
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
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        cell.backgroundColor = .clearColor()
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.ROW_HEIGHT
    }
}
