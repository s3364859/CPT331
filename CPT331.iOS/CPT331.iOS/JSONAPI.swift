//
//  JSONAPIManager.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 10/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class JSONAPI {
    internal init() {}
    
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