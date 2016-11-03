//
//  TutorialWelcomeViewController.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 2/11/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

class TutorialWelcomeViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = "Welcome to EventGuardian"
        titleLabel.makeBold("EventGuardian")
        
        hintLabel.text = "We will help you find Nearby Events and Suburb Info"
        hintLabel.makeBold("Nearby Events", "Suburb Info")
    }
}
