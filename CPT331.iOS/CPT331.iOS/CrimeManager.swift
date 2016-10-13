//
//  CrimeManager.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 13/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire
import SwiftyJSON

class CrimeManager: JSONAPI {
    static let sharedInstance = CrimeManager()
    
    // TODO: move domain to info.plist
    private let ENDPOINT = "http://ec2-52-32-105-85.us-west-2.compute.amazonaws.com/api/Crime/CrimesByCoordinate"
    
    // Prevent external initialization
    private override init() {}
    
    func getCrimeData(atCoordinate coordinate: CLLocationCoordinate2D, completion: (CrimeDataCollection?) -> ()) {
        let parameters:[String:AnyObject] = [
            "latitude": coordinate.latitude,
            "longitude": coordinate.longitude
        ]
        
        super.fetchJSON(self.ENDPOINT, parameters: parameters) { json in
            completion(CrimeDataCollection.fromJSON(json))
        }
    }
}

extension CrimeDataCollection {
    class func fromJSON(json:JSON?) -> CrimeDataCollection? {
        print(json)
        
        guard let beginYear = json?["BeginYear"].int else {
            return nil
        }
        
        guard let endYear = json?["EndYear"].int else {
            return nil
        }
        
        guard let name = json?["Name"].string else {
            return nil
        }
        
        guard let offencesRaw = json?["Offences"].array else {
            return nil
        }
        
        var offences = [CrimeDataOffence]()
        for offence in offencesRaw {
            if let name = offence["Name"].string, let value = offence["Value"].double {
                offences.append((name: name, value: value))
            }
        }
        
        return CrimeDataCollection(name: name, beginYear: beginYear, endYear: endYear, offences: offences)
    }
}