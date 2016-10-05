//
//  WeatherDataPrediction.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 5/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation
import SwiftyJSON

class WeatherDataPrediction:WeatherData {
    let temperature:(
    // The minimum value of temperature during a given day
    min:Double?,
    
    // The maximum value of temperature during a given day
    max:Double?
    )
    
    let precipitation:(
    // The intensity (in millimeters of liquid water per hour) of precipitation occurring at the given time.
    intensity:Double?,
    
    // The probability of precipitation occurring, between 0 and 1, inclusive.
    probability:Double?,
    
    // The type of precipitation occurring at the given time.
    type:PrecipitationType?,
    
    // The amount of snowfall accumulation expected to occur, in Centimeters. (If no snowfall is expected, this property will not be defined.)
    accumulation:Double?
    )
    
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