//
//  LocationViewModel.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 19/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation

class LocationViewModel:EventsViewModel {

    // Set by LocationEventViewConroller
    let location:Location

    // Section sort order
    static let defaultSortOrder:[EventSectionType] = [.Current, .Soon, .NearFuture, .Future, .DistantFuture, .NearPast, .Past]
    private var customSortOrder:[EventSectionType]?
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

    // Set by loadEvents()
    var sections: [EventSection]?


    
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

            self.sections = self.sections(forEvents: cachedEvents, withSortOrder: self.sortOrder!)
            self.delegate?.update()
        }
        
        if useAPI {
            // Fetch events from API
            EventManager.sharedInstance.getEventsFromAPI(atCoordinate: coordinate, withinRadius: radius) { events in
                guard var fetchedEvents = events else {
                    return
                }
                
                if useCache {
                    // Fetch current events from cache
                    let cachedEvents = EventManager.sharedInstance.getEventsFromCache(atCoordinate: coordinate, withinRadius: radius)
                    
                    // Merge cached events into events dictionary
                    fetchedEvents += cachedEvents
                }
                
                self.filterEvents(&fetchedEvents, withWhitelist: whitelist)

                self.sections = self.sections(forEvents: fetchedEvents, withSortOrder: self.sortOrder!)
                self.delegate?.update()
            }
        }
    }

    

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