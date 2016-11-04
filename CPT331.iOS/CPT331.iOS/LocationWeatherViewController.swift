//
//  LocationInfoViewController.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 20/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit
import CoreLocation

/// Handles retrieving and displaying weather data for a particular location
class LocationWeatherViewController: LocationViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // -----------------------------
    // MARK: Constants
    // -----------------------------
    let predictionColumnCount = 4
    
    
    
    // -----------------------------
    // MARK: Runtime Variables
    // -----------------------------
    /// Weather data loaded from async API call
    var weatherData: WeatherDataCollection?
    
    
    
    // -----------------------------
    // MARK: Storyboard References
    // -----------------------------
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentCategoryImageView: UIImageView!
    @IBOutlet weak var currentCategoryNameLabel: UILabel!
    
    @IBOutlet weak var humidityView: WeatherStatView!
    @IBOutlet weak var windSpeedView: WeatherStatView!
    @IBOutlet weak var windBearingView: WeatherStatView!
    
    @IBOutlet weak var predictionCollectionView: UICollectionView!
    @IBOutlet weak var predictionsHeightConstraint: NSLayoutConstraint?
    @IBOutlet weak var attributionButton: UIButton!
    @IBAction func attributionButtonTapped(sender: AnyObject) {
        if let url = NSURL(string: "https://darksky.net/poweredby/") {
            UIApplication.sharedApplication().openURL(url)
        }
    }
    
    
    
    // -----------------------------
    // MARK: Main Logic
    // -----------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.currentTemperatureLabel.text = "??"
        self.currentCategoryNameLabel.text = ""
        
        self.humidityView.type = .Humidity
        self.windSpeedView.type = .WindSpeed
        self.windBearingView.type = .WindBearing
        
        self.predictionCollectionView.backgroundView?.backgroundColor = nil
        self.predictionCollectionView.delegate = self
        self.predictionCollectionView.dataSource = self
        
        // Hide view by default
        self.mainStackView.hidden = true
        
        if NetworkMonitor.sharedInstance.reachable {
            
            // Show loading indicator until view is ready to be displayed
            let indicator = self.view.showLoadingIndicator()
            
            // Load weather data and make view visible again once complete
            self.loadWeatherData(forCoordinate: self.location.coordinate) {
                indicator.removeFromSuperview()
                self.mainStackView.hidden = false
            }
            
        } else {
            self.view.showNetworkMissingIndicator()
        }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.resizeConstraints()
    }
    
    
    /**
        Retrieves weather data from the WeatherManager and updates the view upon completion
     
        - Parameters:
            - coordinate: the geographical location to request data for
            - completion: optional completion handler to be fired once data has been loaded
     */
    func loadWeatherData(forCoordinate coordinate:CLLocationCoordinate2D, completion: (()->())?=nil) {
        WeatherManager.sharedInstance.getWeather(atCoordinate: self.location.coordinate) { data in
            self.weatherData = data
            self.showData()
            
            // Fire completion handler
            completion?()
        }
    }
    
    
    
    // -----------------------------
    // MARK: Helpers
    // -----------------------------
    /// Monitor device rotation so constraints can be updated upon changing, automatically called
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        self.resizeConstraints()
    }
    
    
    /// Hides prediction views when device is in landscape
    func resizeConstraints() {
        if UIDevice.currentDevice().orientation.isLandscape {
            self.predictionsHeightConstraint?.priority = 900
        } else {
            self.predictionsHeightConstraint?.priority = 250
        }
        
        self.view.updateConstraintsIfNeeded()
    }
    
    
    
    // -----------------------------
    // MARK: Data Display
    // -----------------------------
    
    /// Updates the view to reflect the currently stored data
    func showData() {
        guard self.weatherData != nil else {
            return
        }
        
        if let current = self.weatherData?.current {
            // Top view
            if let temperature = current.temperature {
                self.currentTemperatureLabel.text = String(Int(temperature))
            }
            
            if let category = current.category {
                self.currentCategoryNameLabel.text = category.name
                self.currentCategoryImageView.image = category.image
            }
            
            // Middle views
            if let humidity = current.humidity {
                self.humidityView.valueLabel.text = String(Int(humidity * 100))
            } else {
                self.humidityView.valueLabel.text = "?"
            }
            
            if let windSpeed = current.wind.speed {
                self.windSpeedView.valueLabel.text = String(Int(windSpeed))
            } else {
                self.windSpeedView.valueLabel.text = "?"
            }
            
            if let windBearing = current.wind.bearing {
                self.windBearingView.valueLabel.text = String(Double(windBearing).toWindDirectionFromDegrees())
                self.windBearingView.imageView.rotateImage(CGFloat(windBearing), flip: false)
            } else {
                self.windBearingView.valueLabel.text = "?"
            }
        }
        
        self.resizeConstraints()
        self.predictionCollectionView.reloadData()
    }
    
    
    
    
    // -----------------------------
    // MARK: Collection view data source
    // -----------------------------
    
    /// The number of weather predictions to display
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let predictions = self.weatherData?.dailyData {
            return predictions.count
        } else {
            return 0
        }
    }
    
    
    /// Instantiates a collection view cell for the respective weather prediction
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("weatherPredictionCell", forIndexPath: indexPath)
        
        if let predictionCell = cell as? WeatherPredictionCell, let predictions = self.weatherData?.dailyData {
            if indexPath.row < predictions.count  {
                predictionCell.predictionView.prediction = predictions[indexPath.row]
            }
        }
        
        return cell
    }
    
    
    /// Determines the width and height of the cell so that the width is equal to (device width / column count)
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = CGFloat(Int(self.predictionCollectionView.frame.width)/self.predictionColumnCount)
        let height = self.predictionCollectionView.frame.height
        return CGSize(width: width, height: height)
    }
}