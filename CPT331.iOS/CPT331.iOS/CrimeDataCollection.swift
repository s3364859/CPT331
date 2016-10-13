//
//  CrimeDataCollection.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 13/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation

typealias CrimeDataOffence = (name:String,value:Double)

class CrimeDataCollection {
    let name:String
    let beginYear:Int
    let endYear:Int
    let offences:[CrimeDataOffence]
    
    init(name:String, beginYear:Int, endYear:Int, offences: [CrimeDataOffence]) {
        self.name = name
        self.beginYear = beginYear
        self.endYear = endYear
        self.offences = offences
    }
}