//
//  EventViewController.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 22/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

class EventViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var subheadingLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBAction func closeButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    // Passed in from MapViewController or LocationViewController
    var event:Event!
    
    // Async loaded from Eventfinda API
    var detailedEvent:EventDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.headingLabel.text = event.name
        self.subheadingLabel.text = event.category
        
        // Load additional event data for display
        self.event.getDetails { (returnedEvent) in
            if returnedEvent != nil {
                self.detailedEvent = returnedEvent!
                self.update()
            }
        }
        
        // Configure table
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .clearColor()
        self.tableView.tableFooterView = UIView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func update() {
        print(self.detailedEvent)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self.tableView.frame.height/8
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("attributeCell", forIndexPath: indexPath)
        
        switch indexPath.row {
        case 0:
            cell.textLabel?.text = "id"
            cell.detailTextLabel?.text = String(event.id)
        case 1:
            cell.textLabel?.text = "name"
            cell.detailTextLabel?.text = event.name
        case 2:
            cell.textLabel?.text = "coordinate"
            cell.detailTextLabel?.text = "\(event.coordinate.latitude), \(event.coordinate.longitude)"
            
        case 3:
            cell.textLabel?.text = "category"
            cell.detailTextLabel?.text = event.category
            
        case 4:
            cell.textLabel?.text = "startDate"
            cell.detailTextLabel?.text = "[NYI]"
            
        case 5:
            cell.textLabel?.text = "endDate"
            cell.detailTextLabel?.text = "[NYI]"
            
        case 6:
            cell.textLabel?.text = "cancelled"
            cell.detailTextLabel?.text = "[NYI]"
            
        case 7:
            cell.textLabel?.text = "description"
            cell.detailTextLabel?.text = "[NYI]"
        default:
            ()
        }
        
        return cell
    }
}
