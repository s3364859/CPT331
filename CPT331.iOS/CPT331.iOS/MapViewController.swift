//
//  MapViewController.swift
//  SpatioNews
//
//  Created by Peter Weller on 15/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit
import CSVImporter
import Mapbox
import MapboxGeocoder
import SideMenu


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


class MapViewController: UIViewController, MGLMapViewDelegate, MapViewModelDelegate, UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    // Constants
    let searchResultsRowHeight = 50
    let annotationImage = UIImage(named: "Event-Annotation.png")
    
    @IBOutlet weak var mapView: MGLMapView!
    @IBOutlet weak var searchBarView: UIVisualEffectView!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchSubmitButton: UIButton!
    @IBOutlet weak var searchResultsView: UIVisualEffectView!
    @IBOutlet weak var searchResultsTable: UITableView!
    @IBOutlet weak var searchResultsTableHeight: NSLayoutConstraint!
    @IBOutlet weak var searchResultsTableMarginBottom: NSLayoutConstraint!
    
    // Runtime vars
    var viewModel:MapViewModel = MapViewModel()
    var searchResults = [GeocodedPlacemark]()
    var searchQuery:String?
    
    // Stores the most recently tapped location label
    // Used to pass the location to child views
    var lastLocationTapped:Location?
    var lastEventTapped:Event?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup the sidebar menu
        let menu = UISideMenuNavigationController()
        menu.leftSide = true
        SideMenuManager.menuFadeStatusBar = false
        SideMenuManager.menuLeftNavigationController = menu
        
        // Setup search bar
        searchBarView.layer.cornerRadius = 4
        searchTextField.addTarget(self, action: #selector(MapViewController.searchQueryDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        
        // Setup search results
        searchResultsView.layer.cornerRadius = 4
        searchResultsView.hidden = true
        searchResultsTable.backgroundColor = .clearColor()
        searchResultsTable.tableFooterView = UIView()
        searchResultsTable.delegate = self
        searchResultsTable.dataSource = self
        
        // Setup map
        mapView.delegate = self
        viewModel.delegate = self
        
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
        
        // Bind observers to listen to keyboard show/hide events
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MapViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MapViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
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
    
    
    
    
    /* --------------------------------- *
     *         Map Functionality         *
     * --------------------------------- */
    
    // Conform to MapViewModelDelegate
    // Will be called twice after calling mapView.loadEvents:
    //      The first will be the cached events in that region
    //      The second will be fetched events from the API
    func update(forEvents events:[Int:Event]) {
        var annotations = [MGLAnnotation]()
        
        // Remove existing annotations if they exist
        if let existing = mapView.annotations {
            mapView.removeAnnotations(existing)
        }
        
        // Build annotations array
        for (_,event) in events {
            annotations.append(EventPointFeature(event: event))
        }
        
        // Add Markers
        mapView.addAnnotations(annotations)
    }
    
    // Fires when panning, zooming out or transitioning to a new location
    func mapViewRegionIsChanging(mapView: MGLMapView) {
        self.dismissKeyboard()
    }
    
    // Update the markers displayed on the map with the region changes
    func mapView(mapView: MGLMapView, regionDidChangeAnimated animated: Bool) {
        self.viewModel.loadEvents(forMapView: mapView)
    }
    
    // Returns the image to be displayed for a marker on the map
    func mapView(mapView: MGLMapView, imageForAnnotation annotation: MGLAnnotation) -> MGLAnnotationImage? {
        if let eventFeature = annotation as? EventPointFeature {
            let category = eventFeature.event.category
            
            // TODO: implement anotation dequeueing
            if let tintedImage = self.annotationImage?.tintWithColor(category.color) {
                return MGLAnnotationImage(image: tintedImage, reuseIdentifier: category.name)
            }
        }
        
        return nil
    }

    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        if let tap = gestureRecognizer as? UITapGestureRecognizer {
            let pointFeatures = self.mapView.visibleFeatures(at: tap.locationInView(self.mapView)).filter{$0 is MGLPointFeature}
            
            // Because single tap is being intercepted, it's necessary to manually call didSelectannotation
            for feature in pointFeatures {
                
                // If it doesn't have a name attribute, it's probably a marker?
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
    
    // Type = town, village, city
    func locationLabelTapped(location:Location) {
        if location.shouldShowDetails {
            self.lastLocationTapped = location
            self.performSegueWithIdentifier("showLocationView", sender: nil)
        }
    }
    
    func mapView(mapView: MGLMapView, didSelectAnnotation annotation: MGLAnnotation) {
        if let a = annotation as? EventPointFeature {
            self.lastEventTapped = a.event
            self.performSegueWithIdentifier("showEventView", sender: nil)
        }
    }
    
    
    
    
    
    
    /* --------------------------------- *
     *       Search Functionality        *
     * --------------------------------- */
    func searchQueryDidChange(textField:UITextField) {
        if let query = self.searchTextField.text {
            LocationManager.sharedInstance.getSearchPredictions(query, relativeToLocation: self.mapView.userLocation?.location, completion: { (searchResults) in
                if searchResults != nil {
                    
                    // Sort results by distance from user
                    if let userLocation = self.mapView.userLocation?.location {
                        self.searchResults = searchResults!.sort({ $0.distanceFrom(userLocation) < $1.distanceFrom(userLocation)})
                    } else {
                        self.searchResults = searchResults!
                    }
                    
                    self.searchQuery = query
                    
                } else {
                    self.searchResults.removeAll(keepCapacity: false)
                    self.searchQuery = nil
                }
                
                dispatch_async(dispatch_get_main_queue(), {
                    // Hide table if no results, otherwise show
                    if !self.searchTextField.isFirstResponder() || self.searchResults.count == 0 {
                        self.searchResultsView.hidden = true
                    } else {
                        self.searchResultsView.hidden = false
                    }
                    
                    // Request table update
                    self.searchResultsTable.reloadData()
                    
                    // Update search results table to fit all cells
                    UIView.animateWithDuration(0.5, animations: {
                        let height = self.searchResultsRowHeight * self.searchResults.count
                        self.searchResultsTableHeight.constant = CGFloat(height)
                        self.view.setNeedsUpdateConstraints()
                    })
                })
            })
        }
    }
    
    // When the keyboard is shown, update table view bottom constraint to include keyboard height
    func keyboardWillShow(notification: NSNotification) {
        
        let userInfo:NSDictionary = notification.userInfo!
        let keyboardFrame: CGRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).CGRectValue()
        
        let offset = keyboardFrame.size.height
        
        UIView.animateWithDuration(1, animations: {
            self.searchResultsTableMarginBottom.constant = offset + 10
            self.view.layoutIfNeeded()
        })
    }
    
    // Remove keyboard height offset when closing keyboard
    func keyboardWillHide(notification: NSNotification) {
        UIView.animateWithDuration(1, animations: {
            self.searchResultsTableMarginBottom.constant = 10
            self.view.layoutIfNeeded()
        })
    }
    
    
    
    
    
    
    /* --------------------------------- *
     *           Tabular Data            *
     * --------------------------------- */
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResults.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("locationCell", forIndexPath: indexPath) as! LocationListCell
        
        cell.placemark = self.searchResults[indexPath.row]
        cell.userLocation = self.mapView.userLocation
        cell.update(withAttributedText: self.searchQuery)
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Deselect row immediately, selection is only temporarily shown to indicate user touch
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let location = self.searchResults[indexPath.row]
        
        // Update search bar text to use suburb names
        self.searchTextField.text = location.name
        self.searchTextField.resignFirstResponder()
        self.searchQueryDidChange(self.searchTextField)
        
        // Pan to suburb location
        self.mapView.setCenterCoordinate(location.location.coordinate, zoomLevel: 12.5, animated: true)
    }
}