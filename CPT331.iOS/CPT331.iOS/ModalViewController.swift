//
//  LocationViewController.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 20/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

/**
    The ModalViewController handles initializing and displaying a custom modal view window.
    When instantiating, it is expected that a view controller for the sub view is provided.
 */
class ModalViewController: UIViewController, UIGestureRecognizerDelegate {
    
    // -----------------------------
    // MARK: Runtime Variables
    // -----------------------------
    /// View controller to be displayed within the container view
    var subViewController: UIViewController?
    
    /// Completion handler to be executed when the view hides
    var onDisappear: (() -> ())?
    
    
    
    // -----------------------------
    // MARK: Storyboard References
    // -----------------------------
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var visualEffectView: UIVisualEffectView!
    @IBOutlet weak var containerView: UIView!
    
    
    
    // -----------------------------
    // MARK: Main Logic
    // -----------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Round corners
        self.visualEffectView.layer.cornerRadius = 4
        self.visualEffectView.clipsToBounds = true
        
        let backgroundTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(ModalViewController.backgroundTap(_:)))
        backgroundTapRecognizer.delegate = self
        self.backgroundView.addGestureRecognizer(backgroundTapRecognizer)
        
        if let controller = self.subViewController {
            self.loadSubViewController(controller)
        }
    }
    
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        self.onDisappear?()
    }
    
    
    /// Updates the container view to display the specified view controller.
    internal func loadSubViewController(controller: UIViewController) {
        controller.view.frame = self.containerView.frame
        self.addChildViewController(controller)
        self.containerView.addSubview(controller.view)
        controller.didMoveToParentViewController(self)
    }

    
    
    // -----------------------------
    // MARK: Event responders
    // -----------------------------
    
    /// Responds to the background being tapped by dissmissing the view controller
    func backgroundTap(sender: UITapGestureRecognizer?=nil) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
    
    /// Determines if the background touch event should be recognize; it is required that the background itself is being tapped and not a subview.
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        return touch.view == self.backgroundView
    }
}