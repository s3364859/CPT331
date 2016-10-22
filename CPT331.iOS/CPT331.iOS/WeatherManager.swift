//
//  WeatherManager.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 5/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

/// Handles retrieval and parsing of weather prediction data from the Dark Sky JSON API
class WeatherManager: JSONAPI {
    static let sharedInstance = WeatherManager()
    
    // TODO: move domain and API key to info.plist
    /// DarkSky API endpoint for weather data (read-only)
    private let ENDPOINT = "https://api.darksky.net/forecast/5136e36ec5498cfd8c583e3f580d3060"
    
    /// Singleton initializer
    private override init() {}
    
    
    /**
        Asynchronously retrieves weather data from Dark Sky API, parsing it and returning via completion handler
     
        - Parameters:
            - coordiante: the geographical location to request data for
            - date (optional): the date to retrieve prediction for (defaults to current date/time)
            - completion: completion handler to be executed once the data has been retrieved and parsed
    */
    func getWeather(atCoordinate coordinate: CLLocationCoordinate2D, date:NSDate?=nil, completion: (WeatherDataCollection?) -> ()) {
        let endpoint = self.ENDPOINT + "/\(coordinate.latitude),\(coordinate.longitude)"
        
        // TODO: implement date support
        var parameters:[String:AnyObject] = [
            "exclude": "hourly,minutely,flags",
            "units": "ca"
        ]
        
        if date != nil {
            parameters["date"] = date!
        }
        
        super.fetchJSON(endpoint, parameters: parameters) { json in
            completion(WeatherDataCollection.fromJSON(json))
        }
    }
}



/// Adds support to WeatherDataCollection for parsing JSON from the Dark Sky API
extension WeatherDataCollection {
    
    /**
        Parses current weather/prediction data
     
            Expected JSON Format:
            {
                latitude: double,
                longitude: double,
                currently: {
                    ...
                },
                daily: {
                    summary: string,
                    data: [
                        ...
                    ]
                }
            }
     
        - Parameters:
            - JSON: json object containing current/prediction weather data
     
        - Returns: WeatherDataCollection
    */
    class func fromJSON(json:JSON?) -> WeatherDataCollection? {
        
        if let latitude = json?["latitude"].double, let longitude = json?["longitude"].double  {
            let dailySummary = json?["daily"]["summary"].string
            let currentData = WeatherDataCurrent.fromJSON(json?["currently"])
            var dailyData = [WeatherDataPrediction]()
            
            // Parse predictions
            if let daily = json?["daily"]["data"] {
                for (_,day) in daily {
                    if let prediction = WeatherDataPrediction.fromJSON(day) {
                        dailyData.append(prediction)
                    }
                }
            }
            
            return WeatherDataCollection(
                coordinate: CLLocationCoordinate2D(latitude: latitude, longitude: longitude),
                current: currentData,
                dailySummary: dailySummary,
                dailyData: dailyData
            )
            
        } else {
            return nil
        }
    }
}

/// Adds support to WeatherDataCurrent for parsing JSON from the Dark Sky API
extension WeatherDataCurrent {
    
    /**
        Parses current weather data
            
            Expected JSON Format:
            {
                time: double,
                icon: string,
                precipType: string,
                summary: string,
                dewPoint: string,
                humidity: double,
                cloudCover: double,
                pressure: double,
                visibility: double,
                windSpeed: double,
                windBearing: int,
                temperature: double,
                precipIntensity: double,
                precipProbability: double
            }
     
        - Parameters:
            - JSON: json object containing current weather data
     
        - Returns: WeatherDataCurrent
     */
    class func fromJSON(json:JSON?) -> WeatherDataCurrent? {
        
        if let current = json, let unixTime = json?["time"].double {
            let datetime = NSDate(timeIntervalSince1970: unixTime)
            let category:WeatherCategory = current["icon"].string != nil ? WeatherCategory.fromString(current["icon"].string!) : .Unknown
            let precipType:PrecipitationType = current["precipType"].string != nil ? PrecipitationType.fromString(current["precipType"].string!) : .None
            
            return WeatherDataCurrent(
                datetime: datetime,
                category: category,
                summary: current["summary"].string,
                dewPoint: current["dewPoint"].double,
                humidity: current["humidity"].double,
                cloudCover: current["cloudCover"].double,
                pressure: current["pressure"].double,
                visibility: current["visibility"].double,
                windSpeed: current["windSpeed"].double,
                windBearing: current["windBearing"].int,
                temperature: current["temperature"].double,
                precipIntensity: current["precipIntensity"].double,
                precipProbability: current["precipProbability"].double,
                precipType: precipType
            )
            
        } else {
            return nil
        }
    }
}



/// Adds support to WeatherDataPrediction for parsing JSON from the Dark Sky API
extension WeatherDataPrediction {
    
    /**
        Parses weather prediction data

            Expected JSON format:
            {
                time: double,
                icon: string,
                summary: string,
                dewPoint: string,
                humidity: double,
                cloudCover: double,
                pressure: double,
                visibility: double,
                windSpeed: double,
                windBearing: int,
                tempMin: double,
                tempMax: double,
                precipIntensity: double,
                precipProbability: double,
                precipType: string,
                precipAccumulation: double
            }
     
        - Parameters:
            - JSON: json object containing weather prediction data
     
        - Returns: WeatherDataPrediction
     */
    class func fromJSON(json:JSON?) -> WeatherDataPrediction? {
        
        if let prediction = json, let unixTime = json?["time"].double {
            let datetime = NSDate(timeIntervalSince1970: unixTime)
            let category:WeatherCategory = prediction["icon"].string != nil ? WeatherCategory.fromString(prediction["icon"].string!) : .Unknown
            let precipType:PrecipitationType = prediction["precipType"].string != nil ? PrecipitationType.fromString(prediction["precipType"].string!) : .None
            
            return WeatherDataPrediction(
                datetime: datetime,
                category: category,
                summary: prediction["summary"].string,
                dewPoint: prediction["dewPoint"].double,
                humidity: prediction["humidity"].double,
                cloudCover: prediction["cloudCover"].double,
                pressure: prediction["pressure"].double,
                visibility: prediction["visibility"].double,
                windSpeed: prediction["windSpeed"].double,
                windBearing: prediction["windBearing"].int,
                tempMin: prediction["temperatureMin"].double,
                tempMax: prediction["temperatureMax"].double,
                precipIntensity: prediction["precipIntensity"].double,
                precipProbability: prediction["precipProbability"].double,
                precipType: precipType,
                precipAccumulation: prediction["precipAccumulation"].double
            )
            
        } else {
            return nil
        }
    }
}