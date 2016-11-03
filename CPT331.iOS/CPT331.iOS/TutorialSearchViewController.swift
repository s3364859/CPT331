//
//  TutorialSearchViewController.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 2/11/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

class TutorialSearchViewController: UIViewController {
    
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var searchBarView: UIVisualEffectView!
    @IBOutlet weak var searchTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hintLabel.text = "The search bar can be used to Find Suburbs"
        hintLabel.makeBold("Find Suburbs")

        self.searchBarView.layer.cornerRadius = 4
        self.searchTextField.enabled = false
    }
}
