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

class MapViewController: UIViewController, MGLMapViewDelegate, UIGestureRecognizerDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchSubmitButton: UIButton!
    @IBOutlet weak var searchResultsTable: UITableView!
    @IBOutlet weak var mapView: MGLMapView!
    @IBOutlet weak var searchResultsTableHeight: NSLayoutConstraint!
    @IBOutlet weak var searchResultsTableMarginBottom: NSLayoutConstraint!
    
    let searchResultsRowHeight = 50
    var searchResults = [GeocodedPlacemark]()
    var searchQuery:String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup the sidebar menu
        let menu = UISideMenuNavigationController()
        menu.leftSide = true
        SideMenuManager.menuFadeStatusBar = false
        SideMenuManager.menuLeftNavigationController = menu
        
        // Setup search
        searchTextField.addTarget(self, action: #selector(MapViewController.searchQueryDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        searchResultsTable.hidden = true
        searchResultsTable.delegate = self
        searchResultsTable.dataSource = self
        
        // Setup map
        mapView.delegate = self
        
        // Register double tap recognizer so the single tap knows to ignore them
        let doubleTap = UITapGestureRecognizer(target: self, action: nil)
        doubleTap.numberOfTapsRequired = 2
        self.mapView.addGestureRecognizer(doubleTap)
        
        // Register single tap recognizer to check if the user tapped on a city/town/village label
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.mapSingleTapped))
        singleTap.requireGestureRecognizerToFail(doubleTap)
        singleTap.delegate = self
        self.mapView.addGestureRecognizer(singleTap)
        
        // Bind observers to listen to keyboard show/hide events
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MapViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MapViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    
    
    // Fires when panning, zooming out or transitioning to a new location
    func mapViewRegionIsChanging(mapView: MGLMapView) {
        
        // TODO: This call should be made when the user taps on the map too
        self.dismissKeyboard()
    }
    
    func mapSingleTapped(tap: UITapGestureRecognizer) {
        let location = self.mapView.convertPoint(tap.locationInView(self.mapView), toCoordinateFromView: self.mapView)
//        print(String(format: "You tapped at: %.5f, %.5f", location.latitude, location.longitude))
        
        
        for feature in self.mapView.visibleFeatures(at: tap.locationInView(self.mapView)) {
            if feature is MGLPointFeature {
                
                if let name = feature.attributeForKey("name") as? String {
                    if let type = feature.attributeForKey("type") as? String {
                        print(String(format: "%@ label tapped: %@", type, name))
                        showLocationDetails(name, type: type, coordinate: feature.coordinate)
                        
                    } else if let abbr = feature.attributeForKey("abbr") as? String {
                        print(String(format: "State label tapped: %@ (%@)", name, abbr))
                        
                    } else {
                        print("UNKNOWN LABEL TYPE tapped:")
                        print(feature.attributes)
                    }
                }
                
                // Exit loop early if a MGLPointFeature has been found
                break
            }
        }
    }
    
    
    
    
    
    // Type = town, village, city
    func showLocationDetails(title:String, type:String, coordinate:CLLocationCoordinate2D) {
        if [ "city", "town", "village", "suburb"].indexOf(type) != nil {
            print(String(format: "Showing place details for \"%@\" (%@). Location: %F, %F", title, type, coordinate.latitude, coordinate.longitude))
            
//            LocationManager.getLocationInfo(coordinate, completion: { (placemark) in
//                
//            })
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    /* --------------------------------- *
     *       Search Functionality        *
     * --------------------------------- */
    func searchQueryDidChange(textField:UITextField) {
        if let query = self.searchTextField.text {
            let location = self.mapView.userLocation?.location
            
            LocationManager.getSearchPredictions(query, relativeToLocation: self.mapView.userLocation?.location, completion: { (searchResults) in
                if searchResults != nil {
                    if location != nil {
                        self.searchResults = searchResults!.sort({ $0.distanceFrom(location!) < $1.distanceFrom(location!)})
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
                        self.searchResultsTable.hidden = true
                    } else {
                        self.searchResultsTable.hidden = false
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
        
        cell.location = self.searchResults[indexPath.row]
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