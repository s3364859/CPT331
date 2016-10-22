//
//  WeatherDataCurrent.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 5/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation

/// Stores data for weather data at a specific point in time. Extends WeatherData to add support for storing a temperature value and precipitation data.
class WeatherDataCurrent:WeatherData {
    
    /// The current air temperature in degrees Celcius
    let temperature: Double?
    
    /**
        Current precipitation data (read-only)
     
        - Parameters:
            - intensity: the intensity (in millimeters of liquid water per hour) of precipitation occurring at the given time.
            - probaility: the probability of precipitation occurring, between 0 and 1, inclusive.
            - type: the type of precipitation occurring at the given time.
    */
    let precipitation:(intensity:Double?, probability:Double?, type:PrecipitationType?)
    
    init(datetime:NSDate, category:WeatherCategory?, summary:String?, dewPoint:Double?, humidity: Double?, cloudCover: Double?, pressure: Double?, visibility: Double?, windSpeed:Double?, windBearing:Int?, temperature:Double?, precipIntensity:Double?, precipProbability:Double?, precipType: PrecipitationType?) {
        
        self.temperature = temperature
        self.precipitation = (intensity: precipIntensity, probability: precipProbability, type: precipType)
        
        super.init(
            datetime: datetime,
            category: category,
            summary: summary,
            dewPoint: dewPoint,
            humidity: humidity,
            cloudCover: cloudCover,
            pressure: pressure,
            visibility: visibility,
            windSpeed: windSpeed,
            windBearing: windBearing
        )
    }
}