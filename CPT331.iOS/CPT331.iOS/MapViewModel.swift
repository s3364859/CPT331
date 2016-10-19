//
//  MapViewModel.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 19/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation
import Mapbox

class MapViewModel:EventsViewModel {
    let mapView:MGLMapView
    
    init(mapView:MGLMapView) {
        self.mapView = mapView
    }
    
    func loadEvents(withWhitelist whitelist:[EventCategory]?=nil, useCache:Bool=true, useAPI:Bool=true) {
        let bounds = self.mapView.visibleCoordinateBounds
        let center = self.mapView.centerCoordinate
        
        if useCache {
            // Trigger map update for current cached events
            var cachedEvents = EventManager.sharedInstance.getEventsFromCache(withinBounds: bounds)
            self.filterEvents(&cachedEvents, withWhitelist: whitelist)
            self.delegate?.showEvents(cachedEvents)
        }
        
        if useAPI {
            // Fetch events from API
            let radius = self.getRadius(fromCoordinateBounds: bounds)
            EventManager.sharedInstance.getEventsFromAPI(atCoordinate: center, withinRadius: radius) { events in
                guard var events = events else {
                    return
                }
                
                if useCache {
                    // Fetch current events from cache
                    let cachedEvents = EventManager.sharedInstance.getEventsFromCache(withinBounds: bounds)
                    
                    // Merge cached events into events dictionary
                    events += cachedEvents
                }
                
                self.filterEvents(&events, withWhitelist: whitelist)
                self.delegate?.showEvents(events)
            }
        }
    }
}