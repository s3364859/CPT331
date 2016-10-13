//
//  UIImageView.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 11/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

extension UIImageView {
    
    // Source: http://stackoverflow.com/a/37958094
    func imageFromUrl(url:NSURL, showIndicator:Bool=false) {
        
        var indicator:UIActivityIndicatorView?
        
        if showIndicator {
            self.backgroundColor = UIColor(red: 160/255, green: 160/255, blue: 160/255, alpha: 0.5)
            indicator = self.showLoadingIndicator()
        }
        
        
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
            
            dispatch_async(dispatch_get_main_queue(), {
                // Remove indicator if it exists
                indicator?.removeFromSuperview()
                
                self.image = UIImage(data: data)
            })
        }.resume()
    }
}