//
//  MapViewController.swift
//  SpatioNews
//
//  Created by Peter Weller on 15/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit
import Mapbox
import SideMenu

class MapViewController: UIViewController, MGLMapViewDelegate, EventsViewModelDelegate, UIGestureRecognizerDelegate, LocationSearchDelegate {
    
    // -----------------------------
    // MARK: Constants
    // -----------------------------
    
    /// The base image to be used for representing event locations on the map
    let annotationImage = UIImage(named: "Event-Annotation.png")
    
    /// The zoom level to be used when selecting a event from the LocationSearchView
    let selectionZoomLevel:Double = 12.5
    
    /// Offsets used to center a selected suburb/annotation, relative to the visible region between search bar and subview
    let centerOffsets:CoordinateOffset = (
        top: 85, // Search bar
        right: 0,
        bottom: 400, // Subview
        left: 0
    )
    
    
    
    // -----------------------------
    // MARK: Runtime Variables
    // -----------------------------
    var viewModel:MapViewModel!
    
    /// Used to keep track of when the map region is changing
    var mapRegionIsChanging:Bool=false
    
    
    
    // -----------------------------
    // MARK: Storyboard References
    // -----------------------------
    @IBOutlet weak var mapView: MGLMapView!
    @IBOutlet weak var locationSearchView: LocationSearchView!
    
    
    
    // -----------------------------
    // MARK: Main Logic
    // -----------------------------
    
    /// Responsible for initializing: the sidebar menu, map, search box and gesture recognizers
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setup the sidebar menu
        let menu = UISideMenuNavigationController()
        menu.leftSide = true
        SideMenuManager.menuFadeStatusBar = false
        SideMenuManager.menuLeftNavigationController = menu
        
        // Setup map
        self.mapView.delegate = self
        self.viewModel = MapViewModel(mapView: self.mapView)
        self.viewModel.delegate = self
        
        // Setup search
        self.locationSearchView.delegate = self
        
        // Register double tap recognizer so the single tap knows to ignore them
        let doubleTap = UITapGestureRecognizer(target: self, action: nil)
        doubleTap.numberOfTapsRequired = 2
        self.mapView.addGestureRecognizer(doubleTap)

        // Register single tap recognizer to check if the user tapped on a city/town/village label
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.gestureRecognizerBegan))
        singleTap.requireGestureRecognizerToFail(doubleTap)
        singleTap.delegate = self
        singleTap.cancelsTouchesInView = false
        self.mapView.addGestureRecognizer(singleTap)
    }
    
    /**
        Retrieves the current user location
     
        - Returns: User Location
    */
    func getUserLocation() -> CLLocation? {
        return self.mapView.userLocation?.location
    }
    
    
    
    // -----------------------------
    // MARK: Subviews
    // -----------------------------
    
    /**
        Called in response to the menu button being tapped
     
        - Parameters:
            - button: the tapped button
     */
    func menuButtonTapped(button: UIButton) {
        self.performSegueWithIdentifier("showMenu", sender: nil)
    }
    
    
    /**
        Called in response to a location map label or search result being selected. This function will handle transitioning the map visible region and displaying the Location subview.
     
        - Parameters:
            - location: the Location that was selected
            - pan: determines if the map should pan to the Location
            - zoom: determines if the map should zoom in on the Location. Panning must be enabled if zooming.
     */
    func locationSelected(location:Location, pan:Bool=true, zoom:Bool=true) {
        if pan && zoom {
            self.mapView.setCenterCoordinate(location.coordinate, zoomLevel: self.selectionZoomLevel, animated: true, withOffset: self.centerOffsets)
        } else if pan {
            self.mapView.setCenterCoordinate(location.coordinate, zoomLevel: nil, animated: true, withOffset: self.centerOffsets)
        }
        
        self.performSegueWithIdentifier("showLocationView", sender: location)
    }
    
    
    /**
        Called in response to a event map marker being selected. This function will handle transitioning the map visible region and displaying the Event subview.
     
        - Parameters:
            - event: the Event that was selected
            - pan: determines if the map should pan to the Event
            - zoom: determines if the map should zoom in on the Event. Panning must be enabled if zooming.
     */
    func eventSelected(event:Event, pan:Bool=true, zoom:Bool=true) {
        guard let coordinate = event.coordinate else {
            return
        }
        
        if pan && zoom {
            self.mapView.setCenterCoordinate(coordinate, zoomLevel: self.selectionZoomLevel, animated: true, withOffset: self.centerOffsets)
        } else if pan {
            self.mapView.setCenterCoordinate(coordinate, zoomLevel: nil, animated: true, withOffset: self.centerOffsets)
        }
        
        self.performSegueWithIdentifier("showEventView", sender: event)
    }
    
    
    /**
        Handles passing data to the view which is about to be displayed. If the requested view is a ModalViewController, map updates will be disabled until the modal view has disappeared.
     
        - Parameters:
            - segue: the segue object containing information about view controllers involved in segue
            - pan: the object that initiated the segue
     */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let vc = segue.destinationViewController as? ModalViewController, let identifier = segue.identifier {
            switch identifier {
            case "showLocationView":
                vc.location = sender as? Location
            case "showEventView":
                vc.event = sender as? Event
            default:
                ()
            }
            
            // Prevent map from updating while ModalViewController is visible
            // Updating map markers is expensive, it will cause event list view to stutter if not disabled
            self.viewModel.delegate = nil
            vc.onDisappear = {
                self.viewModel.delegate = self
                self.viewModel.loadEvents(useCache: true, useAPI: false)
            }
        }
    }
    
    
    
    // -----------------------------
    // MARK: Map Drawing
    // -----------------------------
    
    /**
        EventsViewModelDelegate function. Handles displaying event annotation markers on the map. To minimise redraw latency, the map will not be updated while panning.
        
        - Parameters:
            - Event dictionary: event ID / event pairs
     
        - Returns: TRUE: if the map markers were updated. FALSE: if the map markers weren't updated.
     */
    func showEvents(events:[Int:Event]) {
        // Only update map if not already panning
        guard self.mapRegionIsChanging == false else {
            return
        }
        
        // Remove existing annotations
        if let existing = mapView.annotations {
            self.mapView.removeAnnotations(existing)
        }
        
        // Filter events without coordinates
        let filteredEvents = events.filter{$0.1.coordinate != nil}
        
        // Build annotations array
        let annotations = filteredEvents.map{(_,event) in EventPointFeature(event: event)}
        
        // Add annotations
        self.mapView.addAnnotations(annotations)
    }

    
    /**
        MGLMapViewDelegate function. Responsible for instantiating or reusing a MGLAnnotationImage, to be displayed in place of a marker on the map. It is expected that the annotation object passed in is an instance of EventPointFeature.
     
        - Parameters:
            - mapView: the map view which the annotation will be displayed on
            - annotation: the annotation object for which an image should be generated
     
        - Returns:
            - annotation image: color-coded marker which reflects the events category. Refer to enum EventCategory for colors.
    */
    // Returns a reusable annotation image which reflects the event category
    func mapView(mapView: MGLMapView, imageForAnnotation annotation: MGLAnnotation) -> MGLAnnotationImage? {
        // Only event features with event categories should have custom images
        guard let category = (annotation as? EventPointFeature)?.event.category else {
            return nil
        }
        
        // Get the resuse identifier for the annotation
        let reuseIdentifier = category.name
        
        // Try to reuse an existing annotation image, if it exists
        var reusableImage = mapView.dequeueReusableAnnotationImageWithIdentifier(reuseIdentifier)
        
        // if the annotation image hasn‘t been used yet, initialize it here with the reuse identifier
        if reusableImage == nil, var image = self.annotationImage?.tintWithColor(category.color) {
            
            // Set the image anchor to the bottom (By default it is center)
            image = image.imageWithAlignmentRectInsets(UIEdgeInsetsMake(0, 0, image.size.height/2, 0))
            reusableImage = MGLAnnotationImage(image: image, reuseIdentifier: reuseIdentifier)
        }
        
        return reusableImage
    }
    
    
    
    // -----------------------------
    // MARK: Map event responders
    // -----------------------------
    
    /// Keeps track of when the map region is changing
    func mapView(mapView: MGLMapView, regionWillChangeAnimated animated: Bool) {
        self.mapRegionIsChanging = true
        self.dismissKeyboard()
    }
    
    
    /// Updates the map view to display event markers within the visible region
    func mapView(mapView: MGLMapView, regionDidChangeAnimated animated: Bool) {
        self.mapRegionIsChanging = false
        self.viewModel.loadEvents(useCache:true)
    }
    
    
    /// Responds to annotations being selected
    func mapView(mapView: MGLMapView, didSelectAnnotation annotation: MGLAnnotation) {
        if let event = (annotation as? EventPointFeature)?.event {
            self.eventSelected(event, pan: true, zoom:false)
        }
    }
    
    
    /**
        Checks to see if the tap gesture should be recognized. If there is a marker present at the tapped location, the gesture will not be recognized. This is necessary because a tap gesture by default will intercept all taps and prevent the maps own gestures from working.
     
        - Parameters:
            - gestureRecognizer: the touch gesture object to be tested
     
        - Returns:
            - TRUE: to proceed with processing touch event. FALSE: to prevent the gesture from being recognized.
    */
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        // Dismiss keyboard whenever the map is tapped
        self.dismissKeyboard()
        
        if let tap = gestureRecognizer as? UITapGestureRecognizer {
            
            // Iterate over each feature, attempting to find an annotation
            for feature in self.mapView.visiblePointFeatures(atGestureLocation: tap) {
                
                // If it doesn't have a name attribute, it's probably an annotation?
                if feature.attributeForKey("name") == nil {
                    return false
                }
            }
        }
        
        return true
    }
    
    
    /**
        Called in response to user touching map. Scans the touched area for location labels; if found, a location subview will be requested.
     
        - Parameters:
            - gestureRecognizer: the touch gesture object to be tested
     */
    func gestureRecognizerBegan(gestureRecognizer: UIGestureRecognizer) {
        let pointFeatures = self.mapView.visiblePointFeatures(atGestureLocation: gestureRecognizer)
        
        // If it has a name attribute, assume it's a location label
        if pointFeatures.count > 0, let name = pointFeatures[0].attributeForKey("name") as? String {
            let feature = pointFeatures[0]
            
            if let type = feature.attributeForKey("type") as? String {
                // Convert object to make it easier to work with
                let location = Location(name: name, type: type, coordinate: feature.coordinate)
                self.locationSelected(location, zoom:false)
            }
        }
    }
}