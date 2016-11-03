//
//  Double.swift
//  SpatioNews
//
//  Created by Peter Weller on 16/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation

extension Double {
    
    /**
        Rounds a double to the specified number of decimal places.
     
        - Parameters:
            - places: the number of decimal places to round to
     
        - Returns: the rounded number
    */
    func roundToPlaces(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return round(self * divisor) / divisor
    }
    
    /// Converts wind bearing from degrees to a string representation
    func toWindDirectionFromDegrees() -> String {
        let directions=["N", "NNE", "NE", "ENE", "E", "ESE", "SE", "SSE", "S", "SSW", "SW", "WSW", "W", "WNW", "NW", "NNW"]
        let i = (self + 11.25) / 22.5
        return directions[Int(i % 16)]
    }
}