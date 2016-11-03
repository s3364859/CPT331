//
//  Event.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 22/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation
import CoreLocation

/// Stores data for a specific event. This class uses optional values for most properties to be flexible in terms of what the Event API returns.
class Event:NSObject {
    
    // -----------------------------
    // MARK: Properties
    // -----------------------------
    
    /// Unique identifier
    let id:Int
    
    /// The name of the event
    var name:String?
    
    /// A short description of the event
    var desc: String?
    
    /// Human-readable street address
    var address:String?
    
    /// Geographical coordinate (lat/lng pair)
    var coordinate:CLLocationCoordinate2D?
    
    /// The date/time of when the event starts
    var beginDateTime:NSDate?
    
    /// The date/time of when the event ends
    var endDateTime:NSDate?
    
    /// Computed property: the duration between the start and end datetimes (Read-only)
    var duration:NSDateComponents? {
        if let begin = self.beginDateTime, let end = self.endDateTime {
            return NSDateComponents.fromRange(begin, end)
        } else {
            return nil
        }
    }
    
    /// Webpage link for the event on Eventfinda
    var url:NSURL?
    
    /// Thumbnail image URL (75x75)
    var thumbnailURL:NSURL?
    
    /// Banner image URL (650x280)
    var bannerURL:NSURL?
    
    /// The subcategory which the event belongs to. (Private)
    private var _subcategory:EventSubcategry?
    
    /// The subcategory which the event belongs to. If an event belongs to no category, .Generic will be returned. (Read-only)
    var subcategory:EventSubcategry {
        get {
            if let s = self._subcategory {
                return s
            } else {
                return .Generic
            }
        }
    }
    
    /// Computed property: the parent category which the event belongs to. (Read-only)
    var category:EventCategory {
        get {
            return self.subcategory.parentCategory
        }
    }
    
    
    
    // -----------------------------
    // MARK: Functions
    // -----------------------------
    
    /// Create a new event object
    init(id:Int, name:String?=nil, desc:String?=nil, address:String?=nil, coordinate:CLLocationCoordinate2D?=nil, beginDateTime:NSDate?=nil, endDateTime:NSDate?=nil, url:NSURL?=nil, thumbnailURL:NSURL?=nil, bannerURL:NSURL?=nil, subcategory:EventSubcategry?=nil) {
        self.id = id
        self.name = name
        self.desc = desc
        self.address = address
        self.coordinate = coordinate
        self.beginDateTime = beginDateTime
        self.endDateTime = endDateTime
        self.url = url
        self.thumbnailURL = thumbnailURL
        self.bannerURL = bannerURL
        self._subcategory = subcategory
    }
    
    /// Update dan existing event object
    func update(name name:String?=nil, desc:String?=nil, address:String?=nil, coordinate:CLLocationCoordinate2D?=nil, beginDateTime:NSDate?=nil, endDateTime:NSDate?=nil, url:NSURL?=nil, thumbnailURL:NSURL?=nil, bannerURL:NSURL?=nil, subcategory:EventSubcategry?=nil) {
        
        self.name = name
        self.desc = desc
        self.address = address
        self.coordinate = coordinate
        self.beginDateTime = beginDateTime
        self.endDateTime = endDateTime
        self.url = url
        self.thumbnailURL = thumbnailURL
        self.bannerURL = bannerURL
        self._subcategory = subcategory
    }
}
