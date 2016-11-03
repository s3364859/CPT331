//
//  TutorialMenuViewController.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 2/11/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

class TutorialMenuViewController: UIViewController {
    
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var searchBarView: UIVisualEffectView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        hintLabel.text = "Use the Menu to customize which events are shown"
        hintLabel.makeBold("Menu")

        // Do any additional setup after loading the view.
        self.searchBarView.layer.cornerRadius = 4
    }
}
