//
//  SearchBarViewController.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 18/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit
import MapboxGeocoder

protocol LocationSearchDelegate {
    func menuButtonTapped(button:UIButton)
    func selectLocation(location:Location, pan:Bool, zoom:Bool)
    func getUserLocation() -> CLLocation?
}

@IBDesignable class LocationSearchView: UIView, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    
    // -----------------------------
    // MARK: Constants
    // -----------------------------
    internal var NIB_NAME = "LocationSearchView"
    internal var DEFAULT_RESULT_HEIGHT:CGFloat = 50
    internal var BUTTON_COLOR = UIColor(red: 164/255, green: 164/255, blue: 164/255, alpha: 1)
    internal var BUTTON_COLOR_SELECTED = UIColor(red: 66/255, green: 151/255, blue: 221/255, alpha: 1)
    
    
    
    // -----------------------------
    // MARK: Runtime Variables
    // -----------------------------
    internal var _resultHeight:CGFloat!
    var delegate:LocationSearchDelegate?
    var searchResults = [GeocodedPlacemark]()
    var searchQuery:String?
    
    
    
    // -----------------------------
    // MARK: Storyboard References
    // -----------------------------
    // Parent Views
    @IBOutlet weak var view: UIView!
    @IBOutlet weak var searchBarView: UIVisualEffectView!
    @IBOutlet weak var searchResultsView: UIVisualEffectView!
    
    // Search Bar
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    
    // Search Results
    @IBOutlet weak var tableView: UITableView!
    
    // Constraints
    @IBOutlet weak var searchBarHeight: NSLayoutConstraint!
    @IBOutlet weak var searchBarTopMargin: NSLayoutConstraint!
    @IBOutlet weak var searchBarLeftMargin: NSLayoutConstraint!
    @IBOutlet weak var searchBarRightMargin: NSLayoutConstraint!
    @IBOutlet weak var searchResultsHeight: NSLayoutConstraint!
    @IBOutlet weak var searchResultsMarginTop: NSLayoutConstraint!
    @IBOutlet weak var searchResultsMarginBottom: NSLayoutConstraint!
    
    @IBAction func menuButtonTapped(sender: AnyObject) {
        self.delegate?.menuButtonTapped(self.menuButton)
    }
    
    @IBAction func searchButtonTapped(sender: AnyObject) {
        if self.textField.isFirstResponder() {
            self.textField.resignFirstResponder()
        } else {
            self.textField.becomeFirstResponder()
        }
    }
    
    
    
    
    
    // -----------------------------
    // MARK: Storyboard Config
    // -----------------------------
    @IBInspectable var barHeight: CGFloat {
        get {
            return self.searchBarHeight.constant
        }
        
        set(height) {
            self.searchBarHeight.constant = height
        }
    }
    
    @IBInspectable var resultHeight: CGFloat {
        get {
            return self._resultHeight
        }
        
        set(height) {
            self._resultHeight = height
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.searchBarView.layer.cornerRadius
        }
        
        set(radius) {
            self.searchBarView.layer.cornerRadius = radius
            self.searchResultsView.layer.cornerRadius = radius
        }
    }
    
    @IBInspectable var margin: CGFloat {
        get {
            return self.searchBarTopMargin.constant
        }
        
        set(constant) {
            self.searchBarTopMargin.constant = constant
            self.searchBarLeftMargin.constant = constant
            self.searchBarRightMargin.constant = constant
            self.searchResultsMarginTop.constant = constant
            self.searchResultsMarginBottom.constant = constant
        }
    }

    
    
    
    
    // -----------------------------
    // MARK: Initializers
    // -----------------------------
    // Called when creating your view programmatically
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.xibSetup()
    }
    
    // Called when creating your view within another interface file.
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.xibSetup()
    }
    
    func xibSetup() {
        // Init view
        self.view = loadViewFromNib()
        self.view.frame = bounds
        self.view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        super.addSubview(self.view)
        
        // Setup search field
        self.textField.delegate = self
        self.searchButton.tintColor = self.BUTTON_COLOR
        
        // Setup serach results table
        self.hideTableView()
        self.tableView.backgroundColor = .clearColor()
        self.tableView.tableFooterView = UIView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self._resultHeight = self.DEFAULT_RESULT_HEIGHT
        
        // Event Bindings
        self.textField.addTarget(self, action: #selector(LocationSearchView.searchQueryDidChange(_:)), forControlEvents: UIControlEvents.EditingChanged)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LocationSearchView.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(LocationSearchView.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: self.NIB_NAME, bundle: bundle)
        let view = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
    
    
    
    // -----------------------------
    // MARK: UIView Override
    // -----------------------------
    // Returns true if touching an interactive element within xib
    override func pointInside(point: CGPoint, withEvent event: UIEvent?) -> Bool {
        for view: UIView in [self.searchBarView, self.searchResultsView] {
            if view.pointInside(self.convertPoint(point, toView: view), withEvent: event) {
                return true
            }
        }
        return false
    }
    
    
    
    // -----------------------------
    // MARK: Search Functionality
    // -----------------------------
    func textFieldDidBeginEditing(textField: UITextField) {
        self.searchButton.tintColor = self.BUTTON_COLOR_SELECTED
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        self.searchButton.tintColor = self.BUTTON_COLOR
    }
    
    func searchQueryDidChange(textField:UITextField) {
        if let query = textField.text {
            let userLocation = self.delegate?.getUserLocation()
            
            LocationManager.sharedInstance.getSearchPredictions(query, relativeToLocation: userLocation, completion: { searchResults in
                if searchResults != nil {
                    
                    // Sort results by distance from user
                    if userLocation != nil {
                        self.searchResults = searchResults!.sort({ $0.distanceFrom(userLocation!) < $1.distanceFrom(userLocation!)})
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
                    if !self.textField.isFirstResponder() || self.searchResults.count == 0 {
                        self.searchResultsView.hidden = true
                        self.hideTableView()
                        
                    } else {
                        // Request table update
                        self.tableView.reloadData()
                        
                        let height = CGFloat(Int(self._resultHeight) * self.searchResults.count)
                        self.searchResultsHeight.constant = CGFloat(height)
                        self.showTableView(withHeight: height)
                    }
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
            self.searchResultsMarginBottom.constant = offset + self.searchResultsMarginTop.constant
            self.layoutIfNeeded()
        })
    }
    
    // Remove keyboard height offset when closing keyboard
    func keyboardWillHide(notification: NSNotification) {
        UIView.animateWithDuration(1, animations: {
            self.searchResultsMarginBottom.constant = self.searchResultsMarginTop.constant
            self.layoutIfNeeded()
        })
    }
    
    
    
    // -----------------------------
    // MARK: Search Results
    // -----------------------------
    func hideTableView() {
        dispatch_async(dispatch_get_main_queue(), {
            self.searchResultsView.hidden = true
            self.searchResultsHeight.constant = 0
            self.layoutIfNeeded()
        })
    }
    
    func showTableView(withHeight height:CGFloat) {
        dispatch_async(dispatch_get_main_queue(), {
            self.searchResultsView.hidden = false
            
            // Update search results table to fit all cells
            UIView.animateWithDuration(0.5, animations: {
                self.searchResultsHeight.constant = height
                self.setNeedsUpdateConstraints()
            })
        })
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchResults.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return self._resultHeight
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("LocationListCell") as? LocationListCell
        if cell == nil {
            // Load the top-level objects from the custom cell XIB.
            var topLevelObjects = NSBundle.mainBundle().loadNibNamed("LocationListCell", owner: self, options: nil)
            // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
            cell = topLevelObjects[0] as? LocationListCell
        }
        
        cell?.backgroundColor = UIColor.clearColor()
        cell?.placemark = self.searchResults[indexPath.row]
        cell?.userLocation = delegate?.getUserLocation()
        cell?.update(withAttributedText: self.searchQuery)
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // Deselect row immediately, selection is only temporarily shown to indicate user touch
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        let placemark = self.searchResults[indexPath.row]
        
        // Clear search bar text
        self.textField.text = ""
        self.textField.resignFirstResponder()
        self.searchQueryDidChange(self.textField)
        
        // Pass data back to parent view
        self.delegate?.selectLocation(placemark.asLocation, pan: true, zoom: true)
    }
}