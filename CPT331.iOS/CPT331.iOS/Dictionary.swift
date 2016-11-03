//
//  Dictionary.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 12/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation

/**
    Merges the dictionary on the right side the operator into the dictionary on the left side.
    
    [Third party code](http://stackoverflow.com/a/24052094) by Stack Overflow user: shucao.
*/
func += <K, V> (inout left: [K:V], right: [K:V]) {
    for (k, v) in right {
        left.updateValue(v, forKey: k)
    }
}