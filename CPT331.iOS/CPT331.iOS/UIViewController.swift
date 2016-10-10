//
//  UIViewController.swift
//  SpatioNews
//
//  Created by Peter Weller on 15/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

extension UIViewController {
    func dismissKeyboard() {
        self.view.endEditing(true)
    }
    
    func showAlert(title:String, message:String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default) { void in })
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func showAlertWithConfirmation(title:String, message:String, acceptButtonLabel label:String, acceptButtonStyle style: UIAlertActionStyle, completion: (() -> ())) {
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        alertController.addAction(UIAlertAction(title: label, style: style) { UIAlertAction in
            completion()
            })
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) { void in })
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func showUnsupportedFeatureAlert(message:String) {
        self.showAlert("Currently unsupported", message: message)
    }
}