//
//  CrimeDataCollection.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 13/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation

typealias CrimeDataOffence = (name:String,value:Double)

/// Stores a collection of crime data offences
class CrimeDataCollection {
    let name:String
    let beginYear:Int
    let endYear:Int
    let offences:[CrimeDataOffence]
    
    /**
        CrimeDataCollection initializer
     
        - Parameters:
            - name: the name of the crime region (local government area, police district etc.)
            - begin year: the year which the crime data starts in
            - end year: the year which the crime data ends in
            - offences: array of offence name/value pairs
    */
    init(name:String, beginYear:Int, endYear:Int, offences: [CrimeDataOffence]) {
        self.name = name
        self.beginYear = beginYear
        self.endYear = endYear
        self.offences = offences
    }
}