//
//  Event.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 22/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation
import CoreLocation

class Event {
    let id:Int
    let name:String
    let coordinate:CLLocationCoordinate2D
    let subcategory:EventSubcategry
    var category:EventCategory {
        get {
            return self.subcategory.parentCategory
        }
    }
    
    init(id:Int, name:String, coordinate:CLLocationCoordinate2D, subcategory:EventSubcategry) {
        self.id = id
        self.name = name
        self.coordinate = coordinate
        self.subcategory = subcategory
    }
    
    func getDetails(completion: (EventDetail?) -> ()) {
        EventManager.getEvent(withId: self.id, completion: completion)
    }
}
