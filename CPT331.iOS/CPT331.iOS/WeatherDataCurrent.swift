//
//  WeatherDataCurrent.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 5/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation
import SwiftyJSON

class WeatherDataCurrent: WeatherData {
    
    // The air temperature in degrees Celcius
    let temperature: Double?
    
    let precipitation:(
    // The intensity (in millimeters of liquid water per hour) of precipitation occurring at the given time.
    intensity:Double?,
    
    // The probability of precipitation occurring, between 0 and 1, inclusive.
    probability:Double?,
    
    // The type of precipitation occurring at the given time.
    type:PrecipitationType?
    )
    
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