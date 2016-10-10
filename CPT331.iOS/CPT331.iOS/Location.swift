//
//  MapLabel.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 22/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation
import CoreLocation

struct Location {
    let name:String
    let type:String
    let coordinate:CLLocationCoordinate2D
    
    // Returns true if the type matches a listed type
    var shouldShowDetails:Bool {
        return [ "city", "town", "village", "suburb"].indexOf(self.type) != nil
    }
    
    init(name:String, type:String, coordinate:CLLocationCoordinate2D) {
        self.name = name
        self.type = type
        self.coordinate = coordinate
    }
}