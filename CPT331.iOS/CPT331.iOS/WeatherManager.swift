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

class WeatherManager {
    private init() {}
    
    private static let APIKEY = "5136e36ec5498cfd8c583e3f580d3060"
    private static let ENDPOINT = "https://api.darksky.net/forecast/\(APIKEY)"
    
    class func getWeather(atCoordinate coordinate: CLLocationCoordinate2D, date:NSDate?=nil, completion: (WeatherDataCollection?) -> ()) {
        let endpoint = self.ENDPOINT + "/\(coordinate.latitude),\(coordinate.longitude)"
        var parameters:[String:AnyObject] = [
            "exclude": "hourly,minutely,flags",
            "units": "ca"
        ]
        
        if date != nil {
            parameters["date"] = date!
        }
        
        fetchJSON(endpoint, parameters: parameters) { json in
            completion(WeatherDataCollection.fromJSON(json))
        }
    }
    
    internal class func fetchJSON(endpoint:String, parameters:[String:AnyObject], completion: (JSON?) -> ()) {
        Alamofire.request(.GET, endpoint, parameters: parameters).responseJSON { response in
            
            guard response.result.error == nil else {
                return completion(nil)
            }
            
            if let data = response.result.value {
                completion(JSON(data))
            } else {
                completion(nil)
            }
        }
    }
}

extension WeatherDataCollection {
    class func fromJSON(json:JSON?) -> WeatherDataCollection? {
        
        if let latitude = json?["latitude"].double, let longitude = json?["longitude"].double  {
            let dailySummary = json?["daily"]["summary"].string
            let currentData = WeatherDataCurrent.fromJSON(json?["current"])
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

extension WeatherDataCurrent {
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

extension WeatherDataPrediction {
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