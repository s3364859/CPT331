//
//  LocationInfoViewController.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 20/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

class LocationWeatherViewController: LocationViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    // Constants
    let predictionColumns = 4
    
    @IBOutlet weak var mainStackView: UIStackView!
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentCategoryImageView: UIImageView!
    @IBOutlet weak var currentCategoryNameLabel: UILabel!
    
    @IBOutlet weak var humidityView: WeatherStatView!
    @IBOutlet weak var windSpeedView: WeatherStatView!
    @IBOutlet weak var windBearingView: WeatherStatView!
    
    @IBOutlet weak var predictionCollectionView: UICollectionView!
    @IBOutlet weak var predictionsHeightConstraint: NSLayoutConstraint?
    
    // Loaded from async api call
    var weatherData: WeatherDataCollection?
    
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
        
        self.mainStackView.hidden = true
        let indicator = self.view.showLoadingIndicator()
        
        WeatherManager.sharedInstance.getWeather(atCoordinate: self.location.coordinate) { data in
            self.weatherData = data
            self.update()
            indicator.removeFromSuperview()
            self.mainStackView.hidden = false
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.updateConstraints()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // Monitor device rotation so constraints can be updated upon changing
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransitionToSize(size, withTransitionCoordinator: coordinator)
        self.updateConstraints()
    }
    
    func updateConstraints() {
        // Hide prediction views when device is in landscape
        if UIDevice.currentDevice().orientation.isLandscape {
            self.predictionsHeightConstraint?.priority = 900
        } else {
            self.predictionsHeightConstraint?.priority = 250
        }
        
        self.view.updateConstraintsIfNeeded()
    }
    
    
    func update() {
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
        
        self.updateConstraints()
        self.predictionCollectionView.reloadData()
    }
    
    
    
    
    /* --------------------------------- *
     *    Prediction Colleciton View     *
     * --------------------------------- */
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let predictions = self.weatherData?.dailyData {
            return predictions.count
        } else {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("weatherPredictionCell", forIndexPath: indexPath)
        
        if let predictionCell = cell as? WeatherPredictionCell, let predictions = self.weatherData?.dailyData {
            if indexPath.row < predictions.count  {
                predictionCell.predictionView.prediction = predictions[indexPath.row]
            }
        }
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let width = CGFloat(Int(self.predictionCollectionView.frame.width)/self.predictionColumns)
        let height = self.predictionCollectionView.frame.height
        return CGSize(width: width, height: height)
    }
}