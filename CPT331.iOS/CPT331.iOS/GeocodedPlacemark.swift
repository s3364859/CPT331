//
//  GeocodedPlacemark.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 19/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation
import MapboxGeocoder

extension GeocodedPlacemark {
    // Convenience function
    func distanceFrom(target: CLLocation) -> Double{
        return self.location.coordinate.distanceFrom(target.coordinate)
    }
}