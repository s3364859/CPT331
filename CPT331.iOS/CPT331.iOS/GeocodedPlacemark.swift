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
    
    /**
        Convenience function for calculating the distance the distance to a CLLocation using the Haversine formula.
     
        - Parameters:
            - location: the core location object to calculate distance between
     
        - Returns: the distance in Meters
     */
    func distanceFrom(target: CLLocation) -> Double{
        return self.location.coordinate.distanceFrom(target.coordinate)
    }
}