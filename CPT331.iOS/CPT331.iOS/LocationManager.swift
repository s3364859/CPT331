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

class LocationManager {
    
    //        let nsw = State.create("New South Wales", abbreviation: "NSW")
    //        let qld = State.create("Queensland", abbreviation: "QLD")
    //        let sa = State.create("South Australia", abbreviation: "SA")
    //        let tas = State.create("Tasmania", abbreviation: "TAS")
    //        let vic = State.create("Victoria", abbreviation: "VIC")
    //        let wa = State.create("Western Australia", abbreviation: "WA")
    //        let act = State.create("Australian Capital Territory", abbreviation: "ACT")
    //        let nt = State.create("Northern Territory", abbreviation: "NT")
    
    
    //        if let path = NSBundle.mainBundle().pathForResource("NSW_Places", ofType: "csv") {
    //            let importer = CSVImporter<[String]>(path: path)
    //            importer.startImportingRecords { $0 }.onFinish { importedRecords in
    //                for record in importedRecords {
    //                    if let lat = Double(record[3]), let lng = Double(record[4]) {
    //                        Suburb.create(record[1], state: nsw!, latitude: lat, longitude: lng)
    //                    }
    //                }
    //            }
    //        }
    
    
    class func getSuburbs(usingSearchQuery query:String, relativeToLocation location: CLLocation?) -> [Suburb] {
        let fetchRequest = NSFetchRequest(entityName: "Suburb")
        fetchRequest.predicate = NSPredicate(format: "(name CONTAINS[cd] %@)", query)
        
        do {
            if let suburbs = try NSManagedObject.getMainContext().executeFetchRequest(fetchRequest) as? [Suburb] {

                // If location data is available, sort locations relative to distance from user
                if location != nil {
                    return suburbs.sort({ $0.distanceFrom(location!) < $1.distanceFrom(location!)})
                    
                // Return suburbs without sorting by distance
                } else {
                    return suburbs
                }
                
            }
            
        } catch let error as NSError {
            print("Error: \(error.userInfo)")
        }
        
        // Return empty array if none found
        return [Suburb]()
    }
    
    // Find a single suburb with a matching name
    class func getSuburb(withName name:String) -> Suburb? {
        let fetchRequest = NSFetchRequest(entityName: "Suburb")
        fetchRequest.fetchLimit = 1
        fetchRequest.predicate = NSPredicate(format: "name == [c] %@", name)
        
        do {
            if let results = try NSManagedObject.getMainContext().executeFetchRequest(fetchRequest) as? [Suburb] {
                if results.count > 0 {
                    return results[0]
                }
            }
        } catch let error as NSError {
            print("Error: \(error.userInfo)")
        }
        
        // Returns nothing if no match was found
        return nil
    }
}