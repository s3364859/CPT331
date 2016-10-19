//
//  EventsViewModel.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 12/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit
import Mapbox

protocol EventsViewModelDelegate {
    func showEvents(events:[Int:Event])
}

class EventsViewModel {
    var delegate:EventsViewModelDelegate?
    
    init() {}
    
    func loadEvents(forMapView mapView: MGLMapView, withWhitelist whitelist:[EventCategory]?=nil, useCache:Bool=true, useAPI:Bool=true) {
        if useCache {
            // Trigger map update for current cached events
            var cachedEvents = EventManager.sharedInstance.getEventsFromCache(withinBounds: mapView.visibleCoordinateBounds)
            if whitelist != nil {
                self.filterEvents(&cachedEvents, withWhitelist: whitelist!)
            }
            
            self.delegate?.showEvents(cachedEvents)
        }
        
        
        if useAPI {
            // Fetch events from API
            let radius = self.getRadius(fromCoordinateBounds: mapView.visibleCoordinateBounds)
            EventManager.sharedInstance.getEventsFromAPI(atCoordinate: mapView.centerCoordinate, withinRadius: radius) { events in
                guard var events = events else {
                    return
                }
                
                if useCache {
                    // Fetch current events from cache
                    let cachedEvents = EventManager.sharedInstance.getEventsFromCache(withinBounds: mapView.visibleCoordinateBounds)
                    
                    // Merge cached events into events dictionary
                    events += cachedEvents
                }
                
                if whitelist != nil {
                    self.filterEvents(&events, withWhitelist: whitelist!)
                }
                
                self.delegate?.showEvents(events)
            }
        }
    }
    
    internal func filterEvents(inout events:[Int:Event], withWhitelist whitelist:[EventCategory]) {
        for (id,event) in events {
            if !whitelist.contains(event.category) {
                events.removeValueForKey(id)
            }
        }
    }
    
    internal func getRadius(fromCoordinateBounds bounds: MGLCoordinateBounds) -> Double {
        let ne = bounds.ne
        let sw = bounds.sw
        
        var point1: CLLocationCoordinate2D!
        var point2: CLLocationCoordinate2D!
        
        // Use longitude if in portrait
        if (sw.longitude - ne.longitude) >= (sw.latitude - ne.latitude) {
            point1 = CLLocationCoordinate2D(latitude: 0, longitude: sw.longitude)
            point2 = CLLocationCoordinate2D(latitude: 0, longitude: ne.longitude)
            
            // Otherwise, use latitude if in landscape
        } else {
            point1 = CLLocationCoordinate2D(latitude: sw.latitude, longitude: 0)
            point2 = CLLocationCoordinate2D(latitude: ne.latitude, longitude: 0)
        }
        
        // Get diameter in meters
        let diameter = point1.distanceFrom(point2)
        let radius = diameter/2
        
        // Return radius in kilometers
        return radius/1000
    }
}