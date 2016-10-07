//
//  WeatherPredictionView.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 6/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

class WeatherPredictionView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    
    private var _prediction:WeatherDataPrediction?
    var prediction:WeatherDataPrediction? {
        get {
            return _prediction
        }
        
        set {
            if let date = newValue?.datetime {
                let formatter = NSDateFormatter()
                formatter.dateFormat = "EEE".uppercaseString
                self.dayLabel.text = formatter.stringFromDate(date)
            } else {
                self.dayLabel.text = "?"
            }
            
            self.imageView.image = newValue?.category?.image
            
            if let temp = newValue?.temperature.max {
                self.tempLabel.text = String(temp.roundToPlaces(1))
            } else {
                self.tempLabel.text = "?"
            }
        }
    }
    
    override func awakeFromNib() {
        NSBundle.mainBundle().loadNibNamed("WeatherPredictionView", owner: self, options: nil)
        self.addSubview(self.contentView)
        self.contentView.sizeToFit(parent: self)
    }
}
