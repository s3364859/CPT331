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
    var searchResults = [Suburb]()

    override func viewDidLoad() {
        super.viewDidLoad()

                let nsw = State.create("New South Wales", abbreviation: "NSW")
                let qld = State.create("Queensland", abbreviation: "QLD")
                let sa = State.create("South Australia", abbreviation: "SA")
                let tas = State.create("Tasmania", abbreviation: "TAS")
                let vic = State.create("Victoria", abbreviation: "VIC")
                let wa = State.create("Western Australia", abbreviation: "WA")
                let act = State.create("Australian Capital Territory", abbreviation: "ACT")
                let nt = State.create("Northern Territory", abbreviation: "NT")
        
        
                if let path = NSBundle.mainBundle().pathForResource("NSW_Places", ofType: "csv") {
                    let importer = CSVImporter<[String]>(path: path)
                    importer.startImportingRecords { $0 }.onFinish { importedRecords in
                        for record in importedRecords {
                            if let lat = Double(record[3]), let lng = Double(record[4]) {
                                Suburb.create(record[1], state: nsw!, latitude: lat, longitude: lng)
                            }
                        }
                    }
                }
        
        
        
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
        
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(self.handleSingleTap))
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
    
    
    
    func handleSingleTap(tap: UITapGestureRecognizer) {
        let location = self.mapView.convertPoint(tap.locationInView(self.mapView), toCoordinateFromView: self.mapView)
        print(String(format: "You tapped at: %.5f, %.5f", location.latitude, location.longitude))
        
        
        for feature in self.mapView.visibleFeatures(at: tap.locationInView(self.mapView)) {
            if feature is MGLPointFeature {
                
                // name = actual place name (not necessarily in english)
                // name_en = english name for the place
                // type = 
                //      Surburbs:   "town" or "village"
                //      Natural parks:  "Protected Area"
                //      City: "city"
                //
                // Notes: state labels do not have a specified type but they appear to be the only label type with "abbr" attribute
                //    e.g. New south Wales "abbr" = "N.S.W."
                
                if let name = feature.attributeForKey("name") as? String {
                    let type = feature.attributeForKey("type")
                    let abbr = feature.attributeForKey("abbr")
                    
                    if type == nil && abbr != nil {
                        print("State label tapped: \(name) (\(abbr!))")
                    } else if type != nil {
                        print("\(type!) label tapped: \(name)... adding annotation")
                        
                        if let suburb = LocationManager.getSuburb(withName: name) {
                            print(" >> Adding marker!")
                            let marker = MGLPointAnnotation()
                            marker.coordinate = feature.coordinate
                            marker.title = suburb.name
                            self.mapView.addAnnotation(marker)
                        } else {
                            print(" >> No matching suburb found, no marker to add")
                        }
                        
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
    
    
    
    
    
    
    
    
    
    
    
    /* --------------------------------- *
     *       Search Functionality        *
     * --------------------------------- */
    func searchQueryDidChange(textField:UITextField) {
        if let query = self.searchTextField.text {
            self.searchResults.removeAll(keepCapacity: false)
            self.searchResults = LocationManager.getSuburbs(usingSearchQuery: query, relativeToLocation: self.mapView.userLocation?.location)
            
            // Execute on main thread so that UI updates can be made
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
        let suburb = self.searchResults[indexPath.row]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("locationCell", forIndexPath: indexPath) as! LocationListCell
        
        cell.primaryLabel.text = suburb.name
        cell.secondaryLabel.text = suburb.state.name
        
        if let location = self.mapView.userLocation?.location {
            cell.distanceUnitsLabel.text = "km"
            cell.distanceValueLabel.text = String((suburb.distanceFrom(location)/1000).roundToPlaces(2))
            
            cell.distanceUnitsLabel.hidden = false
            cell.distanceValueLabel.hidden = false
        } else {
            cell.distanceUnitsLabel.hidden = true
            cell.distanceValueLabel.hidden = true
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Deselect row immediately, selection is only temporarily shown to indicate user touch
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let suburb = self.searchResults[indexPath.row]
        let coords = CLLocationCoordinate2D(latitude: suburb.latitude, longitude: suburb.longitude)

        // Pan to suburb location
        self.mapView.setCenterCoordinate(coords, zoomLevel: 12.5, animated: true)
        
        // Update search bar text to use suburb names
        self.searchTextField.text = suburb.name
        self.searchTextField.resignFirstResponder()
        self.searchQueryDidChange(self.searchTextField)
    }
}