//
//  MGLCoordinateBounds.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 27/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation
import Mapbox

extension MGLCoordinateBounds {
    
    /**
        Calculates the radius of the largest possible circle which would fit inside the coordinate bounds
     
        - Returns: radius in Kilometers
     */
    
    var radiusToFit:Double {
        get {
            let ne = self.ne
            let sw = self.sw
            
            var point1: CLLocationCoordinate2D!
            var point2: CLLocationCoordinate2D!
            
            // Use longitude if in portrait
            if (sw.longitude - ne.longitude) >= (sw.latitude - ne.latitude) {
                point1 = CLLocationCoordinate2D(latitude: 0, longitude: sw.longitude)
                point2 = CLLocationCoordinate2D(latitude: 0, longitude: ne.longitude)
                
                // Otherwise, use latitude if in landscape
            } else {
                point1 = CLLocationCoordinate2D(latitude: sw.latitude, longitude: 0)
                point2 = CLLocationCoordinate2D(latitude: ne.latitude, longitude: 0)
            }
            
            // Get diameter in meters
            let diameter = point1.distanceFrom(point2)
            let radius = diameter/2
            
            // Return radius in kilometers
            return radius/1000
        }
    }
}