//
//  UIViewController.swift
//  SpatioNews
//
//  Created by Peter Weller on 15/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// Dismisses the currently visible keyboard
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
}