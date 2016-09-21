//
//  Event.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 22/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation
import CoreLocation

struct Event {
    //    static let fields:[EventField] = [.id, .name, .coordinate]
    
    let id:Int
    let name:String
    let coordinate:CLLocationCoordinate2D
    
    init(id:Int, name:String, coordinate:CLLocationCoordinate2D) {
        self.id = id
        self.name = name
        self.coordinate = coordinate
    }
    
    func getDetails(completion: (EventDetail?) -> ()) {
        EventManager.getEvent(withId: self.id, completion: completion)
    }
}
