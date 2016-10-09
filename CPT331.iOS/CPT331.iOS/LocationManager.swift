//
//  LocationManager.swift
//  SpatioNews
//
//  Created by Peter Weller on 16/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation
import Mapbox
import MapboxGeocoder

class LocationManager {
    
    internal static var lastSearchTask: NSURLSessionDataTask?

    // Forward geocoding
    class func getSearchPredictions(query:String, autocomplete:Bool=true, relativeToLocation location:CLLocation?=nil, completion: ([GeocodedPlacemark]?) -> ()) {
        // Cancel any tasks if some are already in progress
        if lastSearchTask != nil {
            lastSearchTask!.cancel()
        }
        
        // Fire completion handler early if there is no search query
        guard query.characters.count > 0 else {
            completion(nil)
            return
        }
        
        let options = ForwardGeocodeOptions(query: query)
        options.allowedScopes = [.Locality]
        options.autocompletesQuery = autocomplete
        options.focalLocation = location
        options.allowedISOCountryCodes = ["AU"]
        
        let newTask = Geocoder.sharedGeocoder.geocode(options: options) { (placemarks, attribution, error) in

            guard error == nil else {
                if error?.code != -999 {
                    print("Error for search query: \"\(query)\"")
                    print(error)
                }
                return
            }
            
            completion(placemarks)
        }
        
        lastSearchTask = newTask
    }
    
    // Reverse geocoding
    class func getLocationInfo(coordinate: CLLocationCoordinate2D, completion: (GeocodedPlacemark?) -> ()) {
        let options = ReverseGeocodeOptions(coordinate: coordinate)
        
        Geocoder.sharedGeocoder.geocode(options: options) { (placemarks, attribution, error) in
            if placemarks != nil, let placemark = placemarks?[0] {
                completion(placemark)
            }
        }
    }
}