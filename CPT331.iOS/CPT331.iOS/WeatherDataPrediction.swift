//
//  WeatherDataPrediction.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 5/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation

/// Stores data for a weather prediction. Extends WeatherData to add support for storing temperature ranges and precipitation data.
class WeatherDataPrediction:WeatherData {
    
    /**
        Temperature prediction data (read-only)
     
        - Parameters:
            - min: the minimum value of temperature during a given day
            - max: the maximum value of temperature during a given day
    */
    let temperature:(min:Double?, max:Double?)
    
    
    /**
        Precipitation prediction data (read-only)
     
        - Parameters:
            - intensity: the intensity (in millimeters of liquid water per hour) of precipitation occurring at the given time.
            - probaility: the probability of precipitation occurring, between 0 and 1, inclusive.
            - type: the type of precipitation occurring at the given time.
            - accumulation: The amount of snowfall accumulation expected to occur, in Centimeters. (If no snowfall is expected, this property will be nil)
    */
    let precipitation:(intensity:Double?, probability:Double?, type:PrecipitationType?, accumulation:Double?)
    
    
    init(datetime:NSDate, category:WeatherCategory?, summary:String?, dewPoint:Double?, humidity: Double?, cloudCover: Double?, pressure: Double?, visibility: Double?, windSpeed:Double?, windBearing:Int?, tempMin:Double?, tempMax:Double?, precipIntensity:Double?, precipProbability:Double?, precipType: PrecipitationType?, precipAccumulation:Double?) {
        
        self.temperature = (min: tempMin, max: tempMax)
        self.precipitation = (intensity: precipIntensity, probability: precipProbability, type: precipType, accumulation: precipAccumulation)
        
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