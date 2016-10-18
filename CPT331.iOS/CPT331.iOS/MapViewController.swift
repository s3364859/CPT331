//
//  MapViewController.swift
//  SpatioNews
//
//  Created by Peter Weller on 15/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit
import Mapbox
import MapboxGeocoder


struct Pair<T:Hashable,U:Hashable> : Hashable {
    let values : (T, U)
    
    var hashValue : Int {
        get {
            let (a,b) = values
            return a.hashValue &* 31 &+ b.hashValue
        }
    }
}

// comparison function for conforming to Equatable protocol
func ==<T:Hashable,U:Hashable>(lhs: Pair<T,U>, rhs: Pair<T,U>) -> Bool {
    return lhs.values == rhs.values
}


class MapViewController: UIViewController, MGLMapViewDelegate, MapViewModelDelegate, UIGestureRecognizerDelegate, LocationSearchDelegate {
    
    // -----------------------------
    // MARK: Constants
    // -----------------------------
    let searchResultSelectZoom:Double = 12.5
    let annotationImage = UIImage(named: "Event-Annotation.png")
    let panOffsets:(top:CGFloat, bottom:CGFloat) = (
        top: 85, // Search bar
        bottom: 400 // Subview
    )
    
    
    // -----------------------------
    // MARK: Runtime Variables
    // -----------------------------
    var viewModel:MapViewModel = MapViewModel()
    
    // Stores the most recently tapped location label
    // Used to pass the location to child views
    var lastLocationTapped:Location?
    var lastEventTapped:Event?
    
    // Used to prevent map updatesw while panning
    var mapRegionChanging:Bool=false
    
    
    
    // -----------------------------
    // MARK: Storyboard References
    // -----------------------------
    @IBOutlet weak var mapView: MGLMapView!
    @IBOutlet weak var locationSearchView: LocationSearchView!
    

    
    
    // -----------------------------
    // MARK: Main Logic
    // -----------------------------
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup map
        self.mapView.delegate = self
        self.viewModel.delegate = self
        
        // Setup search
        self.locationSearchView.delegate = self
        
        // Register double tap recognizer so the single tap knows to ignore them
        let doubleTap = UITapGestureRecognizer(target: self, action: nil)
        doubleTap.numberOfTapsRequired = 2
        self.mapView.addGestureRecognizer(doubleTap)

        // Register single tap recognizer to check if the user tapped on a city/town/village label
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.mapSingleTapped))
        singleTap.requireGestureRecognizerToFail(doubleTap)
        singleTap.delegate = self
        singleTap.cancelsTouchesInView = false
        self.mapView.addGestureRecognizer(singleTap)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showLocationView", let location = self.lastLocationTapped {
            let vc = segue.destinationViewController as! ModalViewController
            vc.location = location
            
        } else if segue.identifier == "showEventView", let event = self.lastEventTapped {
            let vc = segue.destinationViewController as! ModalViewController
            vc.event = event
        }
    }
    
    
    
    // -----------------------------
    // MARK: LocationSearchDelegate
    // -----------------------------
    func menuButtonTapped(button: UIButton) {
        print("Menu button tapped!")
    }
    
    func locationSelected(location:Location) {
        self.panMapView(
            toCoordinate: location.coordinate,
            zoomLevel: self.searchResultSelectZoom,
            useOffsets: true,
            animated: true
        )
        
        // Show the selected location in subview
        self.lastLocationTapped = location
        self.performSegueWithIdentifier("showLocationView", sender: nil)
    }
    
    func getUserLocation() -> CLLocation? {
        return self.mapView.userLocation?.location
    }
    
    
    
    
    
    
    
    
    /* --------------------------------- *
     *            Map Drawing            *
     * --------------------------------- */
    
    // Conform to MapViewModelDelegate
    // Will be called twice after calling viewModel.loadEvents():
    //      The first will be the cached events in that region
    //      The second will be fetched events from the API
    func update(forEvents events:[Int:Event]) {
        // Only update map if not already panning
        guard self.mapRegionChanging == false else {
            return
        }
        
        var annotations = [MGLAnnotation]()
        
        // Remove existing annotations if they exist
        if let existing = mapView.annotations {
            mapView.removeAnnotations(existing)
        }
        
        // Build annotations arrayc
        for (_,event) in events {
            
            // Ensure event has coordinate before adding
            if event.coordinate != nil {
                annotations.append(EventPointFeature(event: event))
            }
        }
        
        // Add Markers
        mapView.addAnnotations(annotations)
    }
    
    func mapView(mapView: MGLMapView, regionWillChangeAnimated animated: Bool) {
        self.mapRegionChanging = true
        
        // Dismiss keyboard whenever map region starts changing
        self.dismissKeyboard()
    }
    
    
    // When map region changes, load events for visible region
    func mapView(mapView: MGLMapView, regionDidChangeAnimated animated: Bool) {
        self.mapRegionChanging = false
        self.viewModel.loadEvents(forMapView: mapView)
    }
    
    
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
    
    
    
    /* --------------------------------- *
     *         Map Interactivity         *
     * --------------------------------- */
    
    // Returns an offset coordinate, taking into account top and bottom margins
    func getOffsetCoordinate(coordinate: CLLocationCoordinate2D) -> CLLocationCoordinate2D? {
        // Height of the map frame (in points)
        let mapHeight = self.mapView.frame.height
        
        // The region which is still visible (in between search bar and subview)
        let visibleRegion = mapHeight - (self.panOffsets.top + self.panOffsets.bottom)
        
        // If there is sufficient vertical space, offset coordinate so that it is centered in the visible region
        if visibleRegion > 0 {
            let relativeOffset = (self.panOffsets.top + (visibleRegion/2)) / mapHeight
            
            let bounds = self.mapView.visibleCoordinateBounds
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
    func panMapView(toCoordinate coordinate:CLLocationCoordinate2D, zoomLevel:Double?=nil, useOffsets:Bool=true, animated:Bool=true) {

        // Use zoom level if provided
        if zoomLevel != nil {
            
            // First pan to the actual location with zoomlevel
            self.mapView.setCenterCoordinate(coordinate, zoomLevel: zoomLevel!, direction: self.mapView.direction, animated: false, completionHandler: {
                
                // If useOffsets has been requested, pan again to factor in offset
                // This operation is performed separately because it's difficult to simultanously offset and zoom
                if useOffsets {
                    self.panMapView(toCoordinate: coordinate, zoomLevel: nil, useOffsets: useOffsets, animated: false)
                }
            })
        
        // Else, pan the map without zooming
        } else {
            // Get offset coordinate if possible
            var coordinate = coordinate
            if useOffsets, let offsetCoordinate = self.getOffsetCoordinate(coordinate) {
                coordinate = offsetCoordinate
            }
            
            self.mapView.setCenterCoordinate(coordinate, animated: animated)
        }
    }
    
    // Requests the location view to be shown when called
    func locationLabelTapped(location:Location) {
        if location.shouldShowDetails {
            self.lastLocationTapped = location
            self.panMapView(toCoordinate: location.coordinate)
            self.performSegueWithIdentifier("showLocationView", sender: nil)
        }
    }
    
    // Requests the event view to be shown when called
    func eventTapped(event:Event) {
        self.lastEventTapped = event
        
        if event.coordinate != nil {
            self.panMapView(toCoordinate: event.coordinate!)
        }
        
        self.performSegueWithIdentifier("showEventView", sender: nil)
    }
    
    // Annotation responder
    func mapView(mapView: MGLMapView, didSelectAnnotation annotation: MGLAnnotation) {
        if let a = annotation as? EventPointFeature {
            self.eventTapped(a.event)
        }
    }
    
    // Checks to see if the tap gesture should be recognized. If there is a marker present at the tap
    //  location, the gesture will not be recognized. This is necessary, because (by default) a tap
    //  gesture will intercept all taps and prevent the maps own recognizers from working.
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        
        // Dismiss keyboard whenever the map is tapped
        self.dismissKeyboard()
        
        if let tap = gestureRecognizer as? UITapGestureRecognizer {
            let pointFeatures = self.mapView.visibleFeatures(at: tap.locationInView(self.mapView)).filter{$0 is MGLPointFeature}
            
            // Iterate over each feature, attempting to find an annotation
            for feature in pointFeatures {
                
                // If it doesn't have a name attribute, it's probably an annotation?
                if feature.attributeForKey("name") == nil {
                    return false
                }
            }
        }
        
        return true
    }
    
    
    func mapSingleTapped(tap: UITapGestureRecognizer) {
        let pointFeatures = self.mapView.visibleFeatures(at: tap.locationInView(self.mapView)).filter{$0 is MGLPointFeature}
        
        // If it has a name attribute, assume it's a location label
        if pointFeatures.count > 0, let name = pointFeatures[0].attributeForKey("name") as? String {
            let feature = pointFeatures[0]
            
            if let type = feature.attributeForKey("type") as? String {
                print(String(format: "%@ label tapped: %@", type, name))
                
                // Convert object to make it easier to work with
                locationLabelTapped(Location(name: name, type: type, coordinate: feature.coordinate))
                
            } else if let abbr = feature.attributeForKey("abbr") as? String {
                print(String(format: "State label tapped: %@ (%@)", name, abbr))
                
            } else {
                print("UNKNOWN LABEL TYPE tapped:")
                print(feature.attributes)
            }
        }
    }
}