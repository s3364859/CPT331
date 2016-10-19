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
    var whitelist:EventCategoryWhitelist?
    
    init(mapView:MGLMapView) {
        self.mapView = mapView
        self.whitelist = SettingsManager.sharedInstance.whitelist
        
        super.init()
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(MapViewModel.respondToWhitelistChanged(_:)),
            name:"WhitelistUpdated",
            object: nil
        )
    }
    
    
    
    func loadEvents(useCache useCache:Bool=true, useAPI:Bool=true) {
        let bounds = self.mapView.visibleCoordinateBounds
        let center = self.mapView.centerCoordinate
        
        if useCache {
            // Trigger map update for current cached events
            var cachedEvents = EventManager.sharedInstance.getEventsFromCache(withinBounds: bounds)
            self.filterEvents(&cachedEvents, withWhitelist: self.whitelist)
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
                
                self.filterEvents(&events, withWhitelist: self.whitelist)
                self.delegate?.showEvents(events)
            }
        }
    }
    
    
    
    // -----------------------------
    // MARK: Notification responders
    // -----------------------------
    @objc func respondToWhitelistChanged(notification: NSNotification) {
        print("Updating map")
        self.whitelist = SettingsManager.sharedInstance.whitelist
        self.loadEvents(useCache:true, useAPI:false)
    }
}