//
//  WeatherData.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 5/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation

/// Stores a collection of common weather data. This class uses optional values for most properties to be flexible in terms of what the Weather API returns.
class WeatherData {
    
    /// The date and time of this data-point. (Read-only)
    let datetime:NSDate
    
    /// The weather category of this data-point. (Read-only)
    let category:WeatherCategory?
    
    /// A human-readable text summary. Temperature or snow accumulation units will be displayed as degrees Celcius or as centimers, respectively. (Read-only)
    let summary:String?
    
    /// The dew point in Degrees Celsius. (Read-only)
    let dewPoint:Double?
    
    /// The relative humidity, between 0 and 1, inclusive. (Read-only)
    let humidity:Double?
    
    /// The percentage of sky occluded by clouds, between 0 and 1, inclusive. (Read-only)
    let cloudCover:Double?
    
    /// Sea-level air pressure in Hectopascals. (Read-only)
    let pressure:Double?
    
    /// The average visiblity in kilometers. (Read-only)
    let visibility:Double?

    /**
        Wind-related data (Read-only)
     
        - Parameters:
            - speed: the wind speed in kilometers per hour.
            - bearing: the direction that the wind is coming from in degrees, with true north at 0° and progressing clockwise. (If windSpeed is zero, this value will be nil)
    */
    let wind:(speed:Double?, bearing:Int?)
    
    init(datetime:NSDate, category:WeatherCategory?, summary:String?, dewPoint:Double?, humidity: Double?, cloudCover: Double?, pressure: Double?, visibility: Double?, windSpeed:Double?, windBearing:Int?) {
        self.datetime = datetime
        self.category = category
        self.summary = summary
        self.dewPoint = dewPoint
        self.humidity = humidity
        self.cloudCover = cloudCover
        self.pressure = pressure
        self.visibility = visibility
        self.wind = (speed: windSpeed, bearing: windBearing)
    }
}