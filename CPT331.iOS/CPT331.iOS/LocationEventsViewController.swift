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
    let SEARCH_RADIUS:Double = 10
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel:LocationViewModel!
    
    // Fetched from LocationViewModel
    var events: [Event]?
    
    var indicator:UIActivityIndicatorView?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.backgroundColor = .clearColor()
        self.tableView.tableFooterView = UIView()
        
        self.indicator = self.view.showLoadingIndicator()
        
        self.viewModel = LocationViewModel(location: self.location)
        self.viewModel.delegate = self
        self.viewModel.loadEvents(withinRadius: self.SEARCH_RADIUS, useCache:true)
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
    
    
    func showEvents(events: [Int : Event]) {
        
        // Execute table reload on main thread
        dispatch_async(dispatch_get_main_queue(), {
            self.events = events.map{$0.1}
            self.tableView.reloadData()
        })
        
        self.indicator?.removeFromSuperview()
    }
    
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let events = self.events {
            return events.count
        } else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as! EventsListCell
        
        if let event = self.events?[indexPath.row]  {
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
