//
//  LocationInfoViewController.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 20/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

class LocationWeatherViewController: LocationSubViewController {

    
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentCategoryImageView: UIImageView!
    @IBOutlet weak var currentCategoryNameLabel: UILabel!
    
    @IBOutlet weak var humidityView: WeatherStatView!
    @IBOutlet weak var windSpeedView: WeatherStatView!
    @IBOutlet weak var windBearingView: WeatherStatView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.humidityView.type = .Humidity
        self.windSpeedView.type = .WindSpeed
        self.windBearingView.type = .WindBearing
        
        self.currentTemperatureLabel.text = "??"
        self.currentCategoryNameLabel.text = ""
        
        WeatherManager.getWeather(atCoordinate: self.location.coordinate) { data in
            self.showWeatherData(data)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func showWeatherData(data: WeatherDataCollection?) {
        if let temperature = data?.current?.temperature {
            self.currentTemperatureLabel.text = String(Int(temperature))
        }
        
        if let category = data?.current?.category {
            self.currentCategoryNameLabel.text = category.name
            self.currentCategoryImageView.image = category.image
        }
        
        
        if let humidity = data?.current?.humidity {
            self.humidityView.valueLabel.text = String(Int(humidity * 100))
        } else {
            self.humidityView.valueLabel.text = "?"
        }
        
        if let windSpeed = data?.current?.wind.speed {
            self.windSpeedView.valueLabel.text = String(windSpeed)
        } else {
            self.windSpeedView.valueLabel.text = "?"
        }
        
        if let windBearing = data?.current?.wind.bearing {
            self.windBearingView.valueLabel.text = String(Double(windBearing).toWindDirectionFromDegrees())
            self.windBearingView.imageView.rotateImage(CGFloat(windBearing), flip: false)
        } else {
            self.windBearingView.valueLabel.text = "?"
        }
    }
}
