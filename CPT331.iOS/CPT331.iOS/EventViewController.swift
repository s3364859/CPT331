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
    
    @IBOutlet weak var scrollView: MXScrollView!
    
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventCategoryLabel: UILabel!
    
    
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
    
    // Async loaded from Eventfinda API
    var detailedEvent:EventDetail?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup parallax header
        let headerView = UIImageView()
        headerView.image = UIImage(named: "Background-Nature.jpg")
        headerView.contentMode = .ScaleAspectFill
        let parallax = self.scrollView.parallaxHeader
        parallax.view = headerView
        parallax.height = 150
        parallax.mode = .Fill
        
        self.eventNameLabel.text = self.event.name
        self.eventCategoryLabel.text = self.event.subcategory.name
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        // Disable tab bar
        self.tabBarController?.tabBar.hidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
 }
