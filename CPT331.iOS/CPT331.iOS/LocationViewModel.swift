//
//  LocationViewModel.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 19/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation


class LocationViewModel:EventsViewModel {
    let location:Location
    
    init(location:Location) {
        self.location = location
    }
    
    func loadEvents(withinRadius radius:Double, useCache:Bool=true, useAPI:Bool=true) {
        let coordinate = self.location.coordinate
        let whitelist = SettingsManager.sharedInstance.whitelist
        
        if useCache {
            // Trigger map update for current cached events
            var cachedEvents = EventManager.sharedInstance.getEventsFromCache(atCoordinate: coordinate, withinRadius: radius)
            self.filterEvents(&cachedEvents, withWhitelist: whitelist)
            
            self.delegate?.showEvents(cachedEvents)
        }
        
        if useAPI {
            // Fetch events from API
            EventManager.sharedInstance.getEventsFromAPI(atCoordinate: coordinate, withinRadius: radius) { events in
                guard var events = events else {
                    return
                }
                
                if useCache {
                    // Fetch current events from cache
                    let cachedEvents = EventManager.sharedInstance.getEventsFromCache(atCoordinate: coordinate, withinRadius: radius)
                    
                    // Merge cached events into events dictionary
                    events += cachedEvents
                }
                
                self.filterEvents(&events, withWhitelist: whitelist)
                self.delegate?.showEvents(events)
            }
        }
    }
}