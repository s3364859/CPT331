//
//  LocationCrimeViewController.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 20/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit
import Charts

class LocationCrimeViewController: LocationViewController, ChartViewDelegate {
    @IBOutlet weak var pieChartView: PieChartView!
    
    // Chart Title
    let chartTitleFont       = NSUIFont(name: "HelveticaNeue-Light",  size: 15.0)!
    let chartTitleColor      = NSUIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 1)
    
    // Chart Subtitle
    let chartSubtitleFont    = NSUIFont(name: "HelveticaNeue-Medium", size: 16.0)!
    let chartSubtitleColor   = NSUIColor(red: 0/255, green: 122/255, blue: 255/255, alpha: 0.7)
    
    // Chart Labels
    let chartLabelFont       = NSUIFont(name: "HelveticaNeue-Medium",  size: 13.0)!
    let chartLabelColor      = NSUIColor(red: 1, green: 1, blue: 1, alpha: 1)
    lazy var chartLabelFormatter:NSNumberFormatter = {
        let formatter = NSNumberFormatter()
        formatter.numberStyle = NSNumberFormatterStyle.PercentStyle
        formatter.maximumFractionDigits = 1
        formatter.multiplier = 100
        formatter.percentSymbol = "%"
        
        return formatter
    }()
    
    // Chart Background colors
    let chartColors = [
        UIColor(red:  86/255, green: 226/255, blue: 207/255, alpha: 1), // Teal
        UIColor(red:  86/255, green: 174/255, blue: 226/255, alpha: 1), // Light Blue
        UIColor(red:  86/255, green: 104/255, blue: 226/255, alpha: 1), // Blue
        UIColor(red: 138/255, green:  86/255, blue: 226/255, alpha: 1), // Purple
        UIColor(red: 207/255, green:  86/255, blue: 226/255, alpha: 1), // Purple/pink??
        UIColor(red: 226/255, green:  86/255, blue: 174/255, alpha: 1), // Pink
        UIColor(red: 226/255, green:  86/255, blue: 104/255, alpha: 1), // Red
        UIColor(red: 226/255, green: 137/255, blue:  86/255, alpha: 1), // Orange
        UIColor(red: 226/255, green: 207/255, blue:  86/255, alpha: 1), // Yellow
        UIColor(red: 174/255, green: 226/255, blue:  86/255, alpha: 1), // Light Green
        UIColor(red: 104/255, green: 226/255, blue:  86/255, alpha: 1), // Green
        UIColor(red:  86/255, green: 226/255, blue: 137/255, alpha: 1)  // Sea green
    ]
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Hide view and display indicator while loading
        self.pieChartView.hidden = true
        let indicator = self.view.showLoadingIndicator()
        
        // Fetch data
        CrimeManager.sharedInstance.getCrimeData(atCoordinate: self.location.coordinate) { crimeData in
            
            if let crimeData = crimeData {
                let labels = crimeData.offences.map({$0.name})
                let values = crimeData.offences.map({$0.value})
                
                // Update view
                dispatch_async(dispatch_get_main_queue(), { 
                    self.setChartData(labels, values: values)
                    self.setChartTitle("Crime Data", subtitle: "\(crimeData.beginYear)-\(crimeData.endYear)")
                    self.setChartDescription(crimeData.name)
                })
            }
            
            // Make view visible
            indicator.removeFromSuperview()
            self.pieChartView.hidden = false
        }
    }
    
    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setChartData(labels: [String], values: [Double]) {
        var dataEntries = [ChartDataEntry]()
        
        for i in 0..<labels.count {
            let dataEntry = ChartDataEntry(value: values[i], xIndex: i)
            dataEntries.append(dataEntry)
        }
        
        // Construct data objects
        let dataSet = PieChartDataSet(yVals: dataEntries, label: nil)
        let data = PieChartData(xVals: labels, dataSet: dataSet)
        
        // Chart background color styling
        dataSet.colors = self.chartColors

        // Chart label styling
        self.pieChartView.drawSliceTextEnabled = false
        data.setValueFormatter(self.chartLabelFormatter)
        data.setValueFont(self.chartLabelFont)
        data.setValueTextColor(self.chartLabelColor)
        
        // Add data to chart
        self.pieChartView.data = data
    }
    
    func setChartTitle(title:String?, subtitle:String?) {
        guard let title = title else {
            self.pieChartView.centerAttributedText = nil
            return
        }
        
        let paragraphStyle = NSParagraphStyle.defaultParagraphStyle().mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.lineBreakMode = .ByTruncatingTail
        paragraphStyle.alignment = .Center
        
        let formattedTitle = subtitle != nil ? "\(title)\n\(subtitle!)" : title
        let centerText: NSMutableAttributedString = NSMutableAttributedString(string: formattedTitle)
        
        // Title styling
        centerText.setAttributes([
            NSFontAttributeName: self.chartTitleFont,
            NSParagraphStyleAttributeName: paragraphStyle,
            NSForegroundColorAttributeName: self.chartTitleColor
        ], range: NSMakeRange(0, title.length))
        
        // Subtitle styling
        if subtitle != nil {
            centerText.setAttributes([
                NSFontAttributeName: self.chartSubtitleFont,
                NSParagraphStyleAttributeName: paragraphStyle,
                NSForegroundColorAttributeName: self.chartSubtitleColor
            ], range: NSMakeRange(centerText.length - subtitle!.length , subtitle!.length))
        }
        
        self.pieChartView.centerAttributedText = centerText
    }
    
    func setChartDescription(description:String?) {
        if description != nil {
            self.pieChartView.descriptionText = description!
        } else {
            self.pieChartView.descriptionText = ""
        }
    }
}
