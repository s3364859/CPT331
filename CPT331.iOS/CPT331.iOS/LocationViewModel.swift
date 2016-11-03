//
//  LocationViewModel.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 19/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation

/// Handles loading events for particular location and informing the LocationEventsViewController of when it should update
class LocationViewModel:EventsViewModel {
    
    let location:Location

    /// Sort order to be used if custom sort order has not been set
    static let defaultSortOrder:[EventSectionType] = [.Current, .Soon, .NearFuture, .Future, .DistantFuture, .NearPast, .Past]
    
    /// Non-default sort order
    private var customSortOrder:[EventSectionType]?
    
    /// Custom sort order if set, otherwise default sort order
    var sortOrder:[EventSectionType]? {
        get {
            if customSortOrder != nil {
                return self.customSortOrder
            } else {
                return LocationViewModel.defaultSortOrder
            }
        }

        set {
            self.customSortOrder = newValue
        }
    }

    /// The most recently sorted events
    var sections: [EventSection]?

    
    
    /**
        Initializes a LocationViewModel using the provided location
     
        - Parameters:
            - location: the location to be used as the centerpoint when loading nearby events
    */
    init(location:Location) {
        self.location = location
    }


    /**
        Load events surrounding the stored location that are within the specified radius. Once events have been loaded from a source, a delegate update call will be fired.
     
        - Parameters:
            - use cache: whether or not events should be loaded from the cache (fast)
            - use API: whether or not events should be loaded from the API (slow)
     
        - Note: if sourcing from both cache and API, the delegate update function will be fired twice.
     
        - TODO: search radius should be fetched from SettingsManager once implemented
    */
    func loadEvents(fromCache fromCache:Bool=true, fromAPI:Bool=true) {
        let radius:Double = 20
        let coordinate = self.location.coordinate
        let whitelist = SettingsManager.sharedInstance.whitelist
        
        if fromCache {
            // Trigger map update for current cached events
            var cachedEvents = EventManager.sharedInstance.getEventsFromCache(atCoordinate: coordinate, withinRadius: radius)
            self.filterEvents(&cachedEvents, withWhitelist: whitelist)

            self.sections = self.sections(forEvents: cachedEvents, withSortOrder: self.sortOrder!)
            self.delegate?.showData()
        }
        
        if fromAPI {
            // Fetch events from API
            EventManager.sharedInstance.getEventsFromAPI(atCoordinate: coordinate, withinRadius: radius) { events in
                guard var fetchedEvents = events else {
                    return
                }
                
                if fromCache {
                    // Fetch current events from cache
                    let cachedEvents = EventManager.sharedInstance.getEventsFromCache(atCoordinate: coordinate, withinRadius: radius)
                    
                    // Merge cached events into events dictionary
                    fetchedEvents += cachedEvents
                }
                
                self.filterEvents(&fetchedEvents, withWhitelist: whitelist)

                self.sections = self.sections(forEvents: fetchedEvents, withSortOrder: self.sortOrder!)
                self.delegate?.showData()
            }
        }
    }

    
    /**
        Groups events into sections using the provided sort order.
     
        - Note: EventSectionType.type(forEvent:_) determines which section an event belongs to
     
        - Parameters:
            - events: the events to be sorted
            - sort order: the order in which the event sections should be returned
     
        - TODO: section sort order should be fetched from SettingsManager once implemented
    */
    private func sections(forEvents events:[Int:Event], withSortOrder sortOrder:[EventSectionType]) -> [EventSection] {

        // Sort events into sections
        var sectionsDict = [EventSectionType:EventSection]()
        for (_,event) in events {
            if let type = EventSectionType.type(forEvent: event) {

                // Init section if not exists
                if sectionsDict[type] == nil {
                    sectionsDict[type] = EventSection(type: type)
                }

                sectionsDict[type]?.append(event)
            }
        }

        // Sort event sections
        var sortedSections = [EventSection]()
        for type in sortOrder {
            if let section = sectionsDict[type] {
                section.sort()
                sortedSections.append(section)
            }
        }
        
        return sortedSections
    }
}