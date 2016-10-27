//
//  EventsViewModel.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 12/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit
import Mapbox

/// Delegate to be used to trigger UIView updates
protocol EventsViewModelDelegate {
    func update()
}

/// Abstract class for retrieving data from event API and updating UIView. This class should be subclassed to utilize its functionality.
class EventsViewModel {

    /// The view which should be updated once data has been loaded
    var delegate:EventsViewModelDelegate?
    
    internal init() {}
    
    /**
        Mutates the events dictionary, filtering out any events which have categories that are not whitelisted.
     
        - Parameters:
            - events: dictionary of events (event id / event pairs) to be filtered
            - whitelist: list of event categories which should not be hidden
    */
    internal func filterEvents(inout events:[Int:Event], withWhitelist whitelist:EventCategoryWhitelist?) {
        guard whitelist != nil else {
            return
        }
        
        for (id,event) in events {
            if whitelist!.contains(event.category) == false {
                events.removeValueForKey(id)
            }
        }
    }
}