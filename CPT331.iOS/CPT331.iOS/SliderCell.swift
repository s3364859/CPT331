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
        
        self.selectionStyle = .None
        
        // Add custom recognizers... because the hitbox for default handler is small
        self.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:))))
        self.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:))))
        
        self.updateValueLabel()
    }
    
    // Default handler (Really small)
    @IBAction func sliderValueChanged(sender: AnyObject) {
        self.updateValueLabel()
        self.onSliderChange?(newValue: Double(self.slider.value))
    }
    
    func updateValueLabel() {
        self.valueLabel.text = String(Double(slider.value).roundToPlaces(1))
    }
    
    func handleTapGesture(gesture:UITapGestureRecognizer) {
        if gesture.state == .Ended {
            self.updateValue(forGesture: gesture)
        }
    }
    
    func handlePanGesture(gesture:UIPanGestureRecognizer) {
        if gesture.state == .Changed {
            self.updateValue(forGesture: gesture)
        }
    }
    
    func updateValue(forGesture gesture:UIGestureRecognizer) {
        var percent = gesture.locationOfTouch(0, inView: slider).x/slider.frame.width
        
        // Set lower and upper bounds
        if percent < 0 {
            percent = 0
        } else if percent > 1 {
            percent = 1
        }
        
        slider.value = Float(percent) * slider.maximumValue
        sliderValueChanged(slider)
    }
}