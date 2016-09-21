//
//  EventField.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 22/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation

enum EventField:String {
    case address    = "address"
    case category   = "category"
    case startDate  = "datetime_start"
    case endDate    = "datetime_end"
    case description = "description"
    case id         = "id"
    case cancelled  = "is_cancelled"
    case coordinate = "point"
    case name       = "name"
}