//
//  LocationViewController.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 20/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

class LocationViewController: UIViewController {
    
    let tabButtonNormalColor = UIColor(red: 170/255, green: 170/255, blue: 170/255, alpha: 1)
    let tabButtonSelectedColor = UIColor(red: 66/255, green: 151/255, blue: 221/255, alpha: 1)
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var footerView: UIView!
    
    @IBOutlet weak var headingLabel: UILabel!
    @IBOutlet weak var subheadingLabel: UILabel!
    
    @IBOutlet weak var eventsTabButton: UIButton!
    @IBOutlet weak var crimeTabButton: UIButton!
    @IBOutlet weak var infoTabButton: UIButton!
    
    @IBAction func closeButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    @IBAction func eventsTabButtonTapped(sender: AnyObject) {
        self.toggleSubview("locationEventsView")
    }
    
    @IBAction func crimeTabButtonTapped(sender: AnyObject) {
        self.toggleSubview("locationCrimeView")
    }
    
    @IBAction func infoTabButtonTapped(sender: AnyObject) {
        self.toggleSubview("locationInfoView")
    }
    
    // Passed in from MapViewController
    var location:Location!
    
    // Stores which subview is currently being displayed
    // Used to manage view controller hierarchy
    weak var currentSubview: UIViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Round corners
        self.visualEffectView.layer.cornerRadius = 4
        self.visualEffectView.clipsToBounds = true
        
        self.headingLabel.text = location.name
        
        // Show events view by default
        self.toggleSubview("locationEventsView")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func toggleSubview(id:String) {
        if let vc = self.storyboard?.instantiateViewControllerWithIdentifier(id) as? LocationSubViewController {
            
            // Remove current child view controller (if exists)
            if let current = self.currentSubview {
                for view in self.containerView.subviews {
                    view.removeFromSuperview()
                }
                
                current.willMoveToParentViewController(nil)
                current.removeFromParentViewController()
                self.currentSubview = nil
            }
            
            // Pass location info
            vc.location = self.location
            
            // Add new child view controller
            vc.view.frame = self.containerView.frame
            self.addChildViewController(vc)
            self.containerView.addSubview(vc.view)
            vc.didMoveToParentViewController(self)
            self.currentSubview = vc
            
            // Update button colors
            self.toggleButton(id)
        }
    }
    
    func toggleButton(id:String) {
        switch id {
        case "locationEventsView":
            self.subheadingLabel.text = "Nearby Events"
            self.eventsTabButton.enabled = false
            self.crimeTabButton.enabled = true
            self.infoTabButton.enabled = true
            
        case "locationCrimeView":
            self.subheadingLabel.text = "Crime Statistics"
            self.eventsTabButton.enabled = true
            self.crimeTabButton.enabled = false
            self.infoTabButton.enabled = true
            
        case "locationInfoView":
            self.subheadingLabel.text = "Information"
            self.eventsTabButton.enabled = true
            self.crimeTabButton.enabled = true
            self.infoTabButton.enabled = false
            
        default:
            ()
        }
    }
}