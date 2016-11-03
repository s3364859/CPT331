//
//  TutorialAnnotationViewController.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 2/11/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

class TutorialAnnotationViewController: UIViewController {

    @IBOutlet weak var hintLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hintLabel.text = "Tap on Event Markers to reveal event info"
        hintLabel.makeBold("Event Markers")
    }
}
