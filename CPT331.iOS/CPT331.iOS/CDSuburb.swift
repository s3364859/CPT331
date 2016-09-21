//
//  Suburb.swift
//  SpatioNews
//
//  Created by Peter Weller on 16/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit
import CoreLocation
import CoreData

class CDSuburb: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var state: CDState
    @NSManaged var latitude: Double
    @NSManaged var longitude: Double
    @NSManaged var postcode: Int
    
    lazy var location:CLLocation = CLLocation(latitude: self.latitude, longitude: self.longitude)
    
    class func create(name:String, state:CDState, latitude:Double, longitude:Double, postcode:Int?=nil) -> CDSuburb? {
        let suburb = self.initEntity(withType: "Suburb") as! CDSuburb
        
        suburb.name = name
        suburb.state = state
        suburb.latitude = latitude
        suburb.longitude = longitude
        
        if postcode != nil {
            suburb.postcode = postcode!
        }
        
        if suburb.save() {
            return suburb
        } else {
            return nil
        }
    }
    
    
    // Use haversine formula to calculate distances
    // TODO: CLLocationDistance built in class could be used, but it always returns 0??
    func distanceFrom(location: CLLocation) -> Double{
        // Earth's radius in Kilometers
        let earthRadius: Double = 6371.01
        let kDegreesToRadians: Double = M_PI / 180
        
        // Get the difference between our two points then convert the difference into radians
        let nDLat: Double = (location.coordinate.latitude - self.latitude) * kDegreesToRadians
        let nDLon: Double = (location.coordinate.longitude - self.longitude) * kDegreesToRadians
        let fromLat: Double = self.latitude * kDegreesToRadians
        let toLat: Double = location.coordinate.latitude * kDegreesToRadians
        let nA: Double = pow(sin(nDLat / 2), 2) + cos(fromLat) * cos(toLat) * pow(sin(nDLon / 2), 2)
        let nC: Double = 2 * atan2(sqrt(nA), sqrt(1 - nA))
        let nD: Double = earthRadius * nC
        
        // Return our calculated distance in meters
        return nD * 1000
    }
}
