//
//  PrecipitationType.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 5/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

/// Conveniently stores formatted names and images for each precipitation type
enum PrecipitationType:Int {
    case None=1, Rain, Snow, Sleet
    
    /// The formatted name of the Precipitation type
    var name:String {
        get {
            switch self {
            case .None: return "None"
            case .Rain: return "Rain"
            case .Snow: return "Snow"
            case .Sleet: return "Sleet"
            }
        }
    }
    
    /// Image to be used for visually representing the precipitation in the view
    var image:UIImage? {
        get {
            switch self {
            case .None: return UIImage(named: "Icon-Weather-None.png")
            case .Rain: return UIImage(named: "Icon-Weather-Rain.png")
            case .Snow: return UIImage(named: "Icon-Weather-Snow.png")
            case .Sleet: return UIImage(named: "Icon-Weather-Sleet.png")
            }
        }
    }
    
    /// Parses a string identifier (from API) into a PrecipitationType value
    static func fromString(string:String) -> PrecipitationType {
        switch string {
        case "rain": return .Rain
        case "snow": return .Snow
        case "sleet": return .Sleet
        default: return .None
        }
    }
}