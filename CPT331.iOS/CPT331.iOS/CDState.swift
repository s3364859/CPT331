//
//  State.swift
//  SpatioNews
//
//  Created by Peter Weller on 16/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit
import CoreData

class CDState: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var abbreviation: String
    @NSManaged var suburbs: NSSet
    
    class func create(name:String, abbreviation:String) -> CDState? {
        let state = self.initEntity(withType: "State") as! CDState
        
        state.name = name
        state.abbreviation = abbreviation
        
        if state.save() {
            return state
        } else {
            return nil
        }
    }
}
