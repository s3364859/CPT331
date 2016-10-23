//
//  MGLMapView.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 18/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation
import Mapbox

typealias CoordinateOffset = (top:CGFloat, right:CGFloat, bottom:CGFloat, left:CGFloat)

extension MGLMapView {

    /**
        Calculates an offset map coordinate so that the provided coordinate can appear centered relative to other elements in the view. 
     
        - Note: Currently used by the MapViewController to position a map marker or suburb label between the search bar and modal view.
     
        - Parameters:
            - coordinate: the geographical location (lat/lng pair) to offset
            - offset: CoordinateOffsets for the top, right, bottom and left regions
     
        - Returns: the offset coordinate
     
        - TODO: add support for right/left margins
    */
    func getOffsetCoordinate(coordinate: CLLocationCoordinate2D, offset:CoordinateOffset) -> CLLocationCoordinate2D? {
        // Height of the map frame (in points)
        let mapHeight = self.frame.height
        
        // The region which is still visible (in between search bar and subview)
        let visibleRegion = mapHeight - (offset.top + offset.bottom)
        
        // If there is sufficient vertical space, offset coordinate so that it is centered in the visible region
        if visibleRegion > 0 {
            let relativeOffset = (offset.top + (visibleRegion/2)) / mapHeight
            
            let bounds = self.visibleCoordinateBounds
            let northLatitude = bounds.ne.latitude
            let southLatitude = bounds.sw.latitude
            
            let offsetLatitude = coordinate.latitude + ((southLatitude - northLatitude) * Double(relativeOffset))
            
            // Update coordinate with the modified object
            return CLLocationCoordinate2D(latitude: offsetLatitude, longitude: coordinate.longitude)
            
        } else {
            return nil
        }
    }
    
    
    /**
        Sets the map center coordinate using provided coordinate with the optional zoom level and margin offsets.
     
        - Note: Animations will not be performed if zoom level has been provided
     
        - Parameters:
            - centerCoordinate: the center geographical coordinate which the map should transition to
            - zoomLevel: should be provided if the map should transition to a specific zoom level (Optional)
            - animated: whether or not the transition should be animated
            - offset: the margin offsets for which the provided coordinate should be offset
     */
    func setCenterCoordinate(centerCoordiante:CLLocationCoordinate2D, zoomLevel:Double?=nil, animated:Bool, withOffset offset:CoordinateOffset?) {

        // Use zoom level if provided and is different
        if zoomLevel != nil && zoomLevel != self.zoomLevel {
            
            // First pan to the actual location with zoomlevel
            self.setCenterCoordinate(centerCoordiante, zoomLevel: zoomLevel!, direction: self.direction, animated: false, completionHandler: {
                
                // If useOffsets has been requested, pan again to factor in offset
                // This operation is performed separately because it's difficult to simultanously offset and zoom
                if offset != nil {
                    self.setCenterCoordinate(centerCoordiante, zoomLevel: nil, animated: false, withOffset: offset)
                }
            })
            
        // Else, pan the map without zooming
        } else {
            // Get offset coordinate if possible
            var coordinate = centerCoordiante
            if offset != nil, let offsetCoordinate = self.getOffsetCoordinate(coordinate, offset: offset!) {
                coordinate = offsetCoordinate
            }
            
            self.setCenterCoordinate(coordinate, animated: animated)
        }
    }
    
    
    /**
        Gets the visible point features at a gesture location
     
        - Parameters:
            - gesture: provides the location of the tap within the view
     
        - Returns: an array of MGLPointFeature's
    */
    func visiblePointFeatures(atGestureLocation gesture:UIGestureRecognizer) -> [MGLPointFeature] {
        if let pointFeatures = (self.visibleFeatures(at: gesture.locationInView(self)).filter{$0 is MGLPointFeature}) as? [MGLPointFeature] {
            return pointFeatures
        } else {
            return [MGLPointFeature]()
        }
    }
}