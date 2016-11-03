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

/// Stores current weather data and an array of weather predictions.
class WeatherDataCollection {
    
    /// The geographical location of the data source - typically a weather station
    let coordinate:CLLocationCoordinate2D
    
    /// Stores the prediction for current or requested time
    let current:WeatherDataCurrent?
    
    /// A human-readable summary of the weather forecast for the next 7 days
    let dailySummary:String?
    
    /// Array of weather predictions for the subsequent days including and after the current weather data
    let dailyData:[WeatherDataPrediction]?
    
    init(coordinate:CLLocationCoordinate2D, current: WeatherDataCurrent?, dailySummary:String?, dailyData:[WeatherDataPrediction]?) {
        self.coordinate = coordinate
        self.current = current
        self.dailySummary = dailySummary
        self.dailyData = dailyData
    }
}