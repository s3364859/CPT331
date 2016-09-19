//
//  NSManagedObject.swift
//  SpatioNews
//
//  Created by Peter Weller on 16/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation
import UIKit
import CoreData

extension NSManagedObject {
    class func getMainContext() -> NSManagedObjectContext {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    }
    
    internal class func initEntity(withType type:String) -> NSManagedObject {
        return NSEntityDescription.insertNewObjectForEntityForName(type, inManagedObjectContext: self.getMainContext())
    }
    
    func save() -> Bool {
        do {
            try self.managedObjectContext?.save()
            return true
        } catch let error as NSError {
            print("Error: \(error.userInfo)")
            
            // Reset to previous state if unable to save
            self.managedObjectContext?.reset()
            
            return false
        }
    }
    
    func delete() {
        self.managedObjectContext?.deleteObject(self)
        self.save()
    }
}
