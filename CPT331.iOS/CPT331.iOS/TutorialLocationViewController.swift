//
//  TutorialLocationViewController.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 2/11/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

class TutorialLocationViewController: UIViewController {

    @IBOutlet weak var hintLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        hintLabel.text = "Tap on Suburb Names to reveal nearby events"
        hintLabel.makeBold("Suburb Names")
    }
}
