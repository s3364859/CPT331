//
//  Location.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 22/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation
import CoreLocation

/// Stores data for a named location
class Location:NSObject {
    let name:String
    let type:String
    let coordinate:CLLocationCoordinate2D
    
    /**
        Determines whether or not a detailed location subview should be shown for the event
     
        - Returns: TRUE if the type is "city", "town", "village" or "suburb", FALSE for any other value
    */
    var shouldShowDetails:Bool {
        return [ "city", "town", "village", "suburb"].indexOf(self.type) != nil
    }
    
    /**
        Location Initializer.
     
        - Parameters:
            - name: the name of the location
            - type: the type of the location (obtained from Mapbox label)
            - coordinate: the geographical coordinate (lat/lng pair)
    */
    init(name:String, type:String, coordinate:CLLocationCoordinate2D) {
        self.name = name
        self.type = type
        self.coordinate = coordinate
    }
}