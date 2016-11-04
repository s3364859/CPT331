//
//  SliderCell.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 4/11/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

class SliderCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var unitsLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    var onSliderChange:((newValue:Double)->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
        
        self.updateValueLabel()
    }
    
    @IBAction func sliderValueChanged(sender: AnyObject) {
        self.updateValueLabel()
        
        let value = Double(self.slider.value)
        self.onSliderChange?(newValue: value)
    }
    
    func updateValueLabel() {
        self.valueLabel.text = String(Double(slider.value).roundToPlaces(1))
    }
}