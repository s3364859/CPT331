//
//  EventViewController.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 22/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit
import MXParallaxHeader

class EventViewController: UIViewController {
    
    let bannerHeight:CGFloat = 150
    
    @IBOutlet weak var scrollView: MXScrollView!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventCategoryLabel: UILabel!
    @IBOutlet weak var eventDescriptionLabel: UILabel!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var dateView: EventDataView!
    @IBOutlet weak var durationView: EventDataView!
    @IBOutlet weak var locationView: EventDataView!
    @IBOutlet weak var footerView: UIView!
    @IBOutlet weak var calloutButton: UIButton!
    
    // Open event url in browser when "get more info" button is tapped
    @IBAction func calloutButtonTapped(sender: AnyObject) {
        if let url = self.event.url {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    // Dynamically loaded if event has banner image
    var bannerView:UIImageView?
    
    // Allow the event to be manually set.
    // If not set, fetch it from the tab bar controller
    private var _event:Event?
    var event:Event {
        set {
            self._event = newValue
        }
        
        get {
            if let event = self._event {
                return event
            } else {
                return (self.navigationController as! EventNavigationController).event
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Disable tab bar
        self.tabBarController?.tabBar.hidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.showEvent(self.event)
    }
    
    func showEvent(event:Event) {
        // Load banner image if it exists
        if let url = self.event.bannerURL {
            self.showBannerImage(fromURL: url)
        }
        
        // Header
        self.eventNameLabel.text = self.event.name
        self.eventCategoryLabel.text = self.event.subcategory.name
        self.eventDescriptionLabel.text = self.event.desc

        // Data views
        self.setDataLabel(event.beginDateTime?.toString("EEEE, MMM d @ h:mm a"), forView: dateView)
        self.setDataLabel(event.duration?.string, forView: durationView)
        self.setDataLabel(event.address, forView: locationView)
        
        // Only enable callout button if url exists
        self.calloutButton.enabled = self.event.url != nil ? true : false
    }
    
    func setDataLabel(label:String?, forView view:EventDataView, undefined:String="Not Specified") {
        view.dataLabel.text = label != nil ? label! : undefined
    }
    
    func showBannerImage(fromURL url:NSURL) {
        
        if self.bannerView == nil {
            self.bannerView = UIImageView()
        }
        
        // Setup parallax header
        self.bannerView?.contentMode = .ScaleAspectFill
        
        self.scrollView.parallaxHeader.view = self.bannerView
        self.scrollView.parallaxHeader.height = self.bannerHeight
        self.scrollView.parallaxHeader.mode = .Fill
        
        self.bannerView?.imageFromUrl(url, showIndicator: true)
    }
 }
