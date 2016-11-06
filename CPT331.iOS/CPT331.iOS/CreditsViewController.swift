//
//  CreditsViewController.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 6/11/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

class CreditsViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBAction func confirmButtonTapped(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: {})
    }
}
