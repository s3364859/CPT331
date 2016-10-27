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
    
    /// The event categories which should be shown on the map
    var whitelist:EventCategoryWhitelist?
    
    /// The most recently fetched events
    var events:[Int:Event]?
    
    
    
    /**
        Initializes a MapViewModel using the provided mapView
     
        - Parameters:
            - mapView: the mapView for which events should be loaded in the visible region
     */
    init(mapView:MGLMapView) {
        self.mapView = mapView
        self.whitelist = SettingsManager.sharedInstance.whitelist
        
        super.init()
        
        // Bind observer so we can update map when the user changes the whitelist
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: #selector(MapViewModel.respondToWhitelistChanged(_:)),
            name:"WhitelistUpdated",
            object: nil
        )
    }
    
    
    /**
        Load events that are within the visible region for the stored map view. Once events have been loaded from a source, a delegate update call will be fired.
     
        - Parameters:
            - use cache: whether or not events should be loaded from the cache (fast)
            - use API: whether or not events should be loaded from the API (slow)
     
        - Note: if sourcing from both cache and API, the delegate update function will be fired twice.
     */
    func loadEvents(fromCache fromCache:Bool=true, fromAPI:Bool=true) {
        let bounds = self.mapView.visibleCoordinateBounds
        let center = self.mapView.centerCoordinate
        
        if fromCache {
            // Trigger map update for current cached events
            var cachedEvents = EventManager.sharedInstance.getEventsFromCache(withinBounds: bounds)
            self.filterEvents(&cachedEvents, withWhitelist: self.whitelist)

            self.events = cachedEvents
            self.delegate?.update()
        }
        
        if fromAPI {
            // Fetch events from API
            let radius = bounds.radiusToFit
            EventManager.sharedInstance.getEventsFromAPI(atCoordinate: center, withinRadius: radius) { events in
                guard var fetchedEvents = events else {
                    return
                }
                
                if fromCache {
                    // Fetch current events from cache
                    let cachedEvents = EventManager.sharedInstance.getEventsFromCache(withinBounds: bounds)
                    
                    // Merge cached events into events dictionary
                    fetchedEvents += cachedEvents
                }

                self.filterEvents(&fetchedEvents, withWhitelist: self.whitelist)
                
                self.events = fetchedEvents
                self.delegate?.update()
            }
        }
    }
    
    
    
    // -----------------------------
    // MARK: Notification responders
    // -----------------------------
    @objc func respondToWhitelistChanged(notification: NSNotification) {
        self.whitelist = SettingsManager.sharedInstance.whitelist
        self.loadEvents(fromCache:true, fromAPI:false)
    }
}