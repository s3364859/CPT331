//
//  LocationEventsViewController.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 20/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

class LocationEventsViewController: LocationViewController, UITableViewDataSource, UITableViewDelegate {

    let ROW_HEIGHT:CGFloat = 54
    
    @IBOutlet weak var tableView: UITableView!
    
    // Fetched from API
    var events = [Event]()

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationItem.setTitle(self.location.name, subtitle: "Nearby Events - X (Y km)")

        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        self.tableView.backgroundColor = .clearColor()
        self.tableView.tableFooterView = UIView()
        
        EventManager.sharedInstance.getEvents(atCoordinate: self.location.coordinate, withinRadius: 20, days: 7) { (events) in
            self.events.removeAll(keepCapacity: false)
            
            if events != nil {
                self.events = events!
            }
            
            // Execute table reload on main thread
            dispatch_async(dispatch_get_main_queue(), { 
                self.tableView.reloadData()
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("eventCell", forIndexPath: indexPath) as! EventsListCell
        
        cell.event = self.events[indexPath.row]
        cell.update()
        
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
