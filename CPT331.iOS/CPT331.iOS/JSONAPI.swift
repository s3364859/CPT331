//
//  JSONAPI.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 10/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

/// Abstract class for pulling data from a JSON api. This class should be subclassed to utilize its functionality.
class JSONAPI {
    /// Internal initializer to prevents direct initialization of this class
    internal init() {}
    
    /**
        Retrieves data from a JSON API using a GET request.
     
        - Parameters:
            - endpoint: the url to perform the get request on
            - parameters: key/value pairs to pass data to the server
            - headers: custom HTTP headers to be used for the request
            - completion: fired upon completion of the GET request. Contains JSON data if available.
    */
    internal func fetchJSON(endpoint:String, parameters:[String:AnyObject], headers:[String:String]?=nil, completion: (JSON?) -> ()) {
        Alamofire.request(.GET, endpoint, parameters: parameters, headers: headers).responseJSON { response in
            
            guard response.result.error == nil else {
                return completion(nil)
            }
            
            if let data = response.result.value {
                completion(JSON(data))
            } else {
                completion(nil)
            }
        }
    }
}