//
//  LocationViewController.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 20/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit



class ModalViewController: UIViewController, UIGestureRecognizerDelegate {
    
    enum ModalViewType {
        case Event
        case Location
        
        var identifier:String {
            switch self {
            case .Event: return "eventNavigationController"
            case .Location: return "locationTabBarController"
            }
        }
    }
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var containerView: UIView!
    
    // One of these vars should be passed in from MapViewController
    var location:Location?
    var event:Event?
    
    // Completion handler to be executed when the view hides
    var onDisappear: (() -> ())?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Round corners
        self.visualEffectView.layer.cornerRadius = 4
        self.visualEffectView.clipsToBounds = true
        
        // Ensure at least 1 var is set
        // XOR would be preferred.. but swift no longer supports boolean XOR
        guard ((location != nil) && (event == nil)) || (location == nil) && (event != nil) else {
            print("ModalViewController.ViewDidLoad: Both location & event vars are undefined, unable to display view")
            return
        }
    
        // Toggle desired view
        if location != nil {
            self.toggleSubview(ModalViewType.Location)
        } else if event != nil {
            self.toggleSubview(ModalViewType.Event)
        }
        
        let backgroundTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ModalViewController.backgroundTap(_:)))
        backgroundTapRecognizer.delegate = self
        self.backgroundView.addGestureRecognizer(backgroundTapRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.onDisappear?()
    }
    
    func toggleSubview(type:ModalViewType) {
        if let controller = self.storyboard?.instantiateViewControllerWithIdentifier(type.identifier) {
            
            // Provide Event object
            if type == .Event, let eventController = controller as? EventNavigationController {
                eventController.event = self.event
                
            // Provide Location object
            } else if type == .Location, let locationController = controller as? LocationTabBarController {
                locationController.location = self.location
            }
            
            // Add new child view controller
            controller.view.frame = self.containerView.frame
            self.addChildViewController(controller)
            self.containerView.addSubview(controller.view)
            controller.didMoveToParentViewController(self)
        }
    }
    
    // Remove modal window if the background is tapped
    func backgroundTap(sender: UITapGestureRecognizer?=nil) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    // Require the background to be tapped, and not child elements
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        return touch.view == self.backgroundView
    }
}