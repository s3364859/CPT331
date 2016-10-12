//
//  EventMarker.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 22/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit
import Mapbox

class EventPointFeature: MGLPointFeature {
    var event:Event!
    
    override var coordinate: CLLocationCoordinate2D {
        set {}
        
        get {
            return self.event.coordinate
        }
    }
    
    init(event:Event) {
        self.event = event
        super.init()
    }
}
