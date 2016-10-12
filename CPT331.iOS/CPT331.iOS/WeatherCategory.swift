//
//  WeatherCategory.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 5/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

enum WeatherCategory:Int {
    case Unknown=1, ClearDay, ClearNight, Rain, Snow, Sleet, Wind, Fog, Cloudy, PartlyCloudyDay, PartlyCloudyNight, Hail, Thunderstorm, Tornado
    
    var name:String {
        get {
            switch self {
            case .Unknown: return "Unknown"
            case .ClearDay: return "Clear Day"
            case .ClearNight: return "Clear Night"
            case .Rain: return "Rain"
            case .Snow: return "Snow"
            case .Sleet: return "Sleet"
            case .Wind: return "Wind"
            case .Fog: return "Fog"
            case .Cloudy: return "Cloudy"
            case .PartlyCloudyDay: return "Partly Cloudy Day"
            case .PartlyCloudyNight: return "Partly Cloudy Night"
            case .Hail: return "Hail"
            case .Thunderstorm: return "Thunderstorm"
            case .Tornado: return "Tornado"
            }
        }
    }
    
    var image:UIImage? {
        get {
            switch self {
            case .Unknown: return UIImage(named: "Icon-Weather-Unknown.png")
            case .ClearDay: return UIImage(named: "Icon-Weather-ClearDay.png")
            case .ClearNight: return UIImage(named: "Icon-Weather-ClearNight.png")
            case .Rain: return UIImage(named: "Icon-Weather-Rain.png")
            case .Snow: return UIImage(named: "Icon-Weather-Snow.png")
            case .Sleet: return UIImage(named: "Icon-Weather-Sleet.png")
            case .Wind: return UIImage(named: "Icon-Weather-Wind.png")
            case .Fog: return UIImage(named: "Icon-Weather-Fog.png")
            case .Cloudy: return UIImage(named: "Icon-Weather-Cloudy.png")
            case .PartlyCloudyDay: return UIImage(named: "Icon-Weather-PartlyCloudyDay.png")
            case .PartlyCloudyNight: return UIImage(named: "Icon-Weather-PartlyCloudyNight.png")
            case .Hail: return UIImage(named: "Icon-Weather-Hail.png")
            case .Thunderstorm: return UIImage(named: "Icon-Weather-Thunderstorm.png")
            case .Tornado: return UIImage(named: "Icon-Weather-Tornado.png")
            }
        }
    }
    
    static func fromString(string:String) -> WeatherCategory {
        switch string {
        case "clear-day": return .ClearDay
        case "clear-night": return .ClearNight
        case "rain": return .Rain
        case "snow": return .Snow
        case "sleet": return .Sleet
        case "wind": return .Wind
        case "fog": return .Fog
        case "cloudy": return .Cloudy
        case "partly-cloudy-day": return .PartlyCloudyDay
        case "partly-cloudy-night": return .PartlyCloudyNight
        case "hail": return .Hail
        case "thunderstorm": return .Thunderstorm
        case "tornado": return .Tornado
        default: return .Unknown
        }
    }
}
