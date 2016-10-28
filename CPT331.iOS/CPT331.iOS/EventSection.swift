//
//  EventSection.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 26/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation

class EventSection {

    // Internal
    internal var _events: [Event]

    // Public
    var type: EventSectionType
    var events:[Event] {
        get {
            return self._events
        }
    }

    init(type:EventSectionType) {
        self.type = type
        self._events = [Event] ()
    }


    func sort() {
        if self.type == .NearPast || self.type == .Past {
            self._events.sortInPlace({ $0.beginDateTime! > $1.beginDateTime! })
        } else if self.type == .Current {
            self._events.sortInPlace({ $0.endDateTime! < $1.endDateTime! })
        } else {
            self._events.sortInPlace({ $0.beginDateTime! < $1.beginDateTime! })
        }
    }

    func append(event: Event) {
        self._events.append(event)
    }

    func remove(event: Event) {
        if let index = self._events.indexOf(event) {
            self._events.removeAtIndex(index)
        }
    }

}