//
//  WeatherDataCollection.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 5/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit
import CoreLocation
import SwiftyJSON

class WeatherDataCollection {
    let coordinate:CLLocationCoordinate2D
    
    // Stores the prediction for current or requested time
    let current:WeatherDataCurrent?
    
    let dailySummary:String?
    let dailyData:[WeatherDataPrediction]?
    
    init(coordinate:CLLocationCoordinate2D, current: WeatherDataCurrent?, dailySummary:String?, dailyData:[WeatherDataPrediction]?) {
        self.coordinate = coordinate
        self.current = current
        self.dailySummary = dailySummary
        self.dailyData = dailyData
    }
}