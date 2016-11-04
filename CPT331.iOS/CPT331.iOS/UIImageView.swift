//
//  UIImageView.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 11/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

extension UIImageView {
    
    /**
        Rotates the image within the imageView by the specified amount.
     
        - Note: the original image is replaced by the rotated verion.
     
        - Parameters:
            - degrees: the amount which the image should be rotated
            - flip: whether or not the image should be flipped (Optional, false by default)
    */
    public func rotateImage(degrees: CGFloat, flip: Bool=false) {
        let rotatedImage = self.image?.imageRotatedByDegrees(degrees, flip: flip)
        self.image = rotatedImage
    }
    
    
    /**
        Asynchronously loads an image from a URL, updating the imageview upon completion.
     
        [Third party code](http://stackoverflow.com/a/37958094) by Stack Overflow user: Cody, 2016.
     
        - Parameters:
            - url: the url of the image to download
            - showIndicator: whether or not a loading indicator should be shown while the image is downloading
    */
    func imageFromUrl(url:NSURL, showIndicator:Bool=false) {
        
        var indicator:UIActivityIndicatorView?
        
        if showIndicator {
            self.backgroundColor = UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 0.5)
            
            if NetworkMonitor.sharedInstance.reachable {
                indicator = self.showLoadingIndicator()
            } else {
                self.showNetworkMissingIndicator()
            }
        }
        
        // Download the image if the network is reachable
        if NetworkMonitor.sharedInstance.reachable {
            let request = NSMutableURLRequest(URL: url)
            NSURLSession.sharedSession().dataTaskWithRequest(request) { (data, response, error) in
                guard let data = data where error == nil else{
                    NSLog("Image download error: \(error)")
                    return
                }
                
                if let httpResponse = response as? NSHTTPURLResponse{
                    if httpResponse.statusCode > 400 {
                        let errorMsg = NSString(data: data, encoding: NSUTF8StringEncoding)
                        NSLog("Image download error, statusCode: \(httpResponse.statusCode), error: \(errorMsg!)")
                        return
                    }
                }
                
                // Display the image using returned data
                dispatch_async(dispatch_get_main_queue(), {
                    // Remove indicator if it exists
                    indicator?.removeFromSuperview()
                    
                    self.image = UIImage(data: data)
                })
            }.resume()
        }
    }
}