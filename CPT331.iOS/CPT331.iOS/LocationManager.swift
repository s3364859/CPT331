//
//  LocationManager.swift
//  SpatioNews
//
//  Created by Peter Weller on 16/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation
import Mapbox
import MapboxGeocoder

/// Wrapper for the  Mapbox Geocoding API, enables searching for locatons (forward geocoding), and getting location info for a specific coordinate (reverse geocoding).
class LocationManager {
    static let sharedInstance = LocationManager()
    
    /// Stores a referance to the most recent search task. To be cancelled if a new task starts.
    private var lastSearchTask: NSURLSessionDataTask?
    
    /// Singleton initializer
    private init() {}

    
    /**
        Performs forward geocoding to retrieve location search predictions from Mapbox Geocoding API. The search query must only consist of the following characters, otherwise it will be ignored:
     
            a-z A-Z 0-9 - . , \s
     
        - Parameters:
            - query: the location string to search for
            - autocomplete: TRUE: if partial matching should be enabled. FALSE: if matching full query
            - relativeToLocation: locations around the provided location will be prioritized
            - completion: the completion handler to be executed once the location data has been retrieved
    */
    func getSearchPredictions(query:String, autocomplete:Bool=true, relativeToLocation location:CLLocation?=nil, completion: ([GeocodedPlacemark]?) -> ()) {
        // Cancel any tasks if some are already in progress
        if lastSearchTask != nil {
            lastSearchTask!.cancel()
        }
        
        // Fire completion handler early if there is no search query
        guard query.characters.count > 0 else {
            completion(nil)
            return
        }
        
        // Input validation, string must only contain: a-z A-Z 0-9 - . , \s
        guard query.matchPattern("^[a-zA-Z0-9\\-\\.,\\s']*$") else {
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
    
    
    
    /**
        Performs reverse geocoding to retrieve details for a specific location from Mapbox Geocoding API.
     
        - Parameters:
            - coordinate:the location to be used to request additional data
            - completion: the completion handler to be executed once the location data has been retrieved
     */
    func getLocationInfo(coordinate: CLLocationCoordinate2D, completion: (GeocodedPlacemark?) -> ()) {
        let options = ReverseGeocodeOptions(coordinate: coordinate)
        
        Geocoder.sharedGeocoder.geocode(options: options) { (placemarks, attribution, error) in
            if placemarks != nil, let placemark = placemarks?[0] {
                completion(placemark)
            }
        }
    }
}