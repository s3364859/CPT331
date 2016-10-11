//
//  EventDataView.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 11/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

@IBDesignable class EventDataView: UIView {
    let nibName = "EventDataView"
    
    @IBOutlet weak var imageWidth: NSLayoutConstraint!
    @IBOutlet weak var imageMargin: NSLayoutConstraint!
    @IBOutlet weak var titleMargin: NSLayoutConstraint!
    @IBOutlet weak var dataMargin: NSLayoutConstraint!
    @IBOutlet weak var titleWidth: NSLayoutConstraint!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dataLabel: UILabel!
    
    
    
    @IBInspectable var image: UIImage? {
        get {
            return imageView.image
        }
        set(image) {
            imageView.image = image
        }
    }
    
    @IBInspectable var imageSize: CGFloat {
        get {
            return imageWidth.constant
        }
        
        set(width) {
            imageWidth.constant = width
            self.updateConstraintsIfNeeded()
        }
    }
    
    @IBInspectable var title:String? {
        get {
            return self.titleLabel.text
        }
        
        set(title) {
            self.titleLabel.text = title
        }
    }
    
    @IBInspectable var titleSize: CGFloat {
        get {
            return titleWidth.constant
        }
        
        set(width) {
            titleWidth.constant = width
            self.updateConstraintsIfNeeded()
        }
    }
    
    @IBInspectable var titleColor: UIColor {
        get {
            return titleLabel.textColor
        }
        
        set(color) {
            titleLabel.textColor = color
        }
    }
    
    // Assumes margins should be identical
    @IBInspectable var margin:CGFloat {
        get {
            return self.imageMargin.constant
        }
        
        set(margin) {
            self.imageMargin.constant = margin
            self.titleMargin.constant = margin
            self.dataMargin.constant = margin
        }
    }
    
    // Our custom view from the XIB file
    var view: UIView!
    
    // Called when creating your view programmatically
    override init(frame: CGRect) {
        // setup any properties here
        
        super.init(frame: frame)
        xibSetup()
    }
    
    // Called when creating your view within another interface file.
    required init?(coder aDecoder: NSCoder) {
        // setup any properties here
        
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        view = loadViewFromNib()
        view.frame = bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        super.addSubview(view)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        
        return view
    }
}
