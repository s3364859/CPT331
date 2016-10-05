//
//  WeatherData.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 5/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation

class WeatherData {
    let datetime:NSDate
    
    let category:WeatherCategory?
    
    // Any summaries containing temperature or snow accumulation units will have their values in degrees Celsius or in centimeters (respectively).
    let summary:String?
    
    // The dew point in Degrees Celsius.
    let dewPoint:Double?
    
    // The relative humidity, between 0 and 1, inclusive.
    let humidity:Double?
    
    // The percentage of sky occluded by clouds, between 0 and 1, inclusive.
    let cloudCover:Double?
    
    // Sea-level air pressure in Hectopascals
    let pressure:Double?
    
    // The average visiblity in kilometers
    let visibility:Double?

    let wind:(
        // The wind speed in kilometers per hour.
        speed:Double?,
    
        // The direction that the wind is coming from in degrees, with true north at 0° and progressing clockwise. (If windSpeed is zero, then this value will not be defined.)
        bearing:Int?
    )
    
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