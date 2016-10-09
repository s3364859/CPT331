//
//  LocationListCell.swift
//  SpatioNews
//
//  Created by Peter Weller on 16/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit
import Mapbox
import MapboxGeocoder

class LocationListCell: UITableViewCell {
    
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var secondaryLabel: UILabel!
    @IBOutlet weak var distanceValueLabel: UILabel!
    @IBOutlet weak var distanceUnitsLabel: UILabel!
    
    var placemark:GeocodedPlacemark!
    var userLocation: MGLUserLocation?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func update(withAttributedText query:String?=nil) {
        if let name = self.placemark.addressDictionary?["name"] as? String {
            primaryLabel.hidden = false
            
            // Format the text, to bold the portion which matches search query
            if let query = query {
                let attributedString = NSMutableAttributedString(string: name, attributes: [NSFontAttributeName:UIFont.systemFontOfSize(15.0)])
                attributedString.addAttributes(
                    [NSFontAttributeName: UIFont.boldSystemFontOfSize(15.0)],
                    range: (name.lowercaseString as NSString).rangeOfString(query.lowercaseString)
                )
                primaryLabel.attributedText = attributedString
                
            // Unformatted text
            } else {
                primaryLabel.text = name
            }
            
        } else {
            primaryLabel.hidden = true
        }
        
        if let state = self.placemark.addressDictionary?["state"] as? String {
            secondaryLabel.text = state
            secondaryLabel.hidden = false
        } else {
            secondaryLabel.hidden = true
        }
        
        // Calculate and display distance from user
        if let userCoordinate = self.userLocation?.coordinate {
            let locationCoordinate = self.placemark.location.coordinate
            
            // Distance to location in meters
            let distance = userCoordinate.distanceFrom(locationCoordinate)
            
            distanceUnitsLabel.text = "km"
            distanceValueLabel.text = String((distance/1000).roundToPlaces(2))
            
            distanceUnitsLabel.hidden = false
            distanceValueLabel.hidden = false
        } else {
            distanceUnitsLabel.hidden = true
            distanceValueLabel.hidden = true
        }
    }
}
