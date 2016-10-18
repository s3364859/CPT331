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
    
    // Returns an offset coordinate using provided margins
    // TODO: add support for right/left margins
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
    
    
    // Note: Animations will not be performed if zoom level has been provided
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
    
    
    func visiblePointFeatures(atGestureLocation gesture:UIGestureRecognizer) -> [MGLPointFeature] {
        if let pointFeatures = (self.visibleFeatures(at: gesture.locationInView(self)).filter{$0 is MGLPointFeature}) as? [MGLPointFeature] {
            return pointFeatures
        } else {
            return [MGLPointFeature]()
        }
    }
}