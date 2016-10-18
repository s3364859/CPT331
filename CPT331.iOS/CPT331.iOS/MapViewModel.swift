//
//  EventViewModel.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 12/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit
import Mapbox

protocol MapViewModelDelegate {
    func showAnnotations(forEvents events:[Int:Event])
}

class MapViewModel {
    var delegate:MapViewModelDelegate?
    
    init() {}
    
    func loadEvents(forMapView mapView: MGLMapView) {
        
        // Trigger map update for current cached events
        self.delegate?.showAnnotations(forEvents: EventManager.sharedInstance.getEventsFromCache(withinBounds: mapView.visibleCoordinateBounds))
        
        // Calcualte radius
        let radius = self.getRadius(fromCoordinateBounds: mapView.visibleCoordinateBounds)
        
        // Fetch events from API
        EventManager.sharedInstance.getEventsFromAPI(atCoordinate: mapView.centerCoordinate, withinRadius: radius) { events in
            
            if var fetchedEvents = events {
                // Fetch current events fromc cache
                let cachedEvents = EventManager.sharedInstance.getEventsFromCache(withinBounds: mapView.visibleCoordinateBounds)
                
                // Merge cached events into events dictionary
                fetchedEvents += cachedEvents
                
                // Trigger map update for cached events
                self.delegate?.showAnnotations(forEvents: fetchedEvents)
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