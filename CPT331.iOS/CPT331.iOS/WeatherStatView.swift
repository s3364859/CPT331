//
//  WeatherStatView.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 6/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

enum WeatherStatType {
    case None
    case Humidity
    case WindSpeed
    case WindBearing
}

class WeatherStatView: UIView {

    @IBOutlet var contentView: UIView!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var unitLabel: UILabel!
    
    @IBOutlet private weak var unitLabelWidth: NSLayoutConstraint!
    
    @IBOutlet weak var labelSpacing: NSLayoutConstraint!
    
    private var _showUnits = true
    var showUnits:Bool {
        get {
            return _showUnits
        }
        
        set {
            self._showUnits = newValue
            
            if newValue == true {
                self.unitLabel.hidden = false
                self.unitLabelWidth.priority = 250
                self.labelSpacing.constant = 3
            } else {
                self.unitLabel.hidden = true
                self.unitLabelWidth.priority = 750
                self.labelSpacing.constant = 0
            }
            
            self.layoutIfNeeded()
        }
    }
    
    private var _type:WeatherStatType!
    var type:WeatherStatType {
        get {
            return _type
        }
        
        set {
            switch newValue {
            case .Humidity:
                self.imageView.image = UIImage(named: "Icon-Weather-Humidity.png")
                self.unitLabel.text = "%"
                self.showUnits = true
                
            case .WindSpeed:
                self.imageView.image = UIImage(named: "Icon-Weather-WindSpeed.png")
                self.unitLabel.text = "km/h"
                self.showUnits = true
                
            case .WindBearing:
                self.imageView.image = UIImage(named: "Icon-Weather-WindBearing.png")
                self.unitLabel.text = ""
                self.showUnits = false
                
            case .None:
                self.imageView.image = nil
                self.valueLabel.text = ""
                self.unitLabel.text = ""
                self.showUnits = false
            }
            
            self._type = newValue
        }
    }
    
    override func awakeFromNib() {
        NSBundle.mainBundle().loadNibNamed("WeatherStatView", owner: self, options: nil)
        self.addSubview(self.contentView)
        self.type = .None
    }
}
