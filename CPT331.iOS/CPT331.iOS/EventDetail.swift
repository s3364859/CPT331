//
//  EventDetail.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 22/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation
import CoreLocation

class EventDetail: Event {
    let startDate:NSDate
    let endDate:NSDate
    let cancelled:Bool
    let description:String?
    
    init(id:Int, name:String, coordinate:CLLocationCoordinate2D, startDate:NSDate, endDate:NSDate, cancelled:Bool=false, subcategory:EventSubcategry, description:String?=nil) {

        self.startDate = startDate
        self.endDate = endDate
        self.cancelled = cancelled
        self.description = description
        
        super.init(id: id, name: name, coordinate: coordinate, subcategory: subcategory)
    }
}
