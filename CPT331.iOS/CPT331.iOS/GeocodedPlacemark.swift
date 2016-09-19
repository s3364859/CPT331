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
    func distanceFrom(target: CLLocation) -> Double{
        
        // Earth's radius in Kilometers
        let earthRadius: Double = 6371.01
        let kDegreesToRadians: Double = M_PI / 180
        
        // Get the difference between our two points then convert the difference into radians
        let nDLat: Double = (target.coordinate.latitude - self.location.coordinate.latitude) * kDegreesToRadians
        let nDLon: Double = (target.coordinate.longitude - self.location.coordinate.longitude) * kDegreesToRadians
        let fromLat: Double = self.location.coordinate.latitude * kDegreesToRadians
        let toLat: Double = target.coordinate.latitude * kDegreesToRadians
        let nA: Double = pow(sin(nDLat / 2), 2) + cos(fromLat) * cos(toLat) * pow(sin(nDLon / 2), 2)
        let nC: Double = 2 * atan2(sqrt(nA), sqrt(1 - nA))
        let nD: Double = earthRadius * nC
        
        // Return our calculated distance in meters
        return nD * 1000
    }
}