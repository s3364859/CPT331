//
//  EventDetail.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 22/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation
import CoreLocation

struct EventDetail {
    //    static let fields:[EventField] = [.id, .name, .coordinate, .startDate, .endDate, .coordinate, .description, .cancelled]
    
    let id:Int
    let name:String
    let coordinate:CLLocationCoordinate2D
    
    // Extra params
    let startDate:NSDate
    let endDate:NSDate
    let cancelled:Bool
    let description:String?
    let categories:[String]?
    
    init(id:Int, name:String, coordinate:CLLocationCoordinate2D, startDate:NSDate, endDate:NSDate, cancelled:Bool=false, description:String?=nil, categories:[String]?=nil) {
        self.id = id
        self.name = name
        self.coordinate = coordinate
        self.startDate = startDate
        self.endDate = endDate
        self.cancelled = cancelled
        self.categories = categories
        self.description = description
    }
}
