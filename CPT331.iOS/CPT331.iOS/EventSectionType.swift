//
//  EventSectionType.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 26/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import Foundation

enum EventSectionType {
    case Current
    case Soon
    case NearFuture
    case Future
    case DistantFuture
    case NearPast
    case Past

    var name:String {
        get {
            switch self {
            case .Current: return "In progress"
            case .Soon: return "Today"
            case .NearFuture: return "Next 3 days"
            case .Future: return "Next 7 days"
            case .DistantFuture: return "Future"
            case .NearPast: return "Recently Finished"
            case .Past: return "Past Events"
            }
        }
    }

    static func type(forEvent event: Event) -> EventSectionType? {
        guard let begin = event.beginDateTime, let end = event.endDateTime else {
            return nil
        }

        // Currently in progress
        if begin.isPast() && end.isFuture() {
            return .Current

            // Starts today, but not yet started
        } else if begin.isFuture() && begin.isToday() {
            return .Soon

            // Precise matching
        } else {
            let now = NSDate()
            let hoursFromEnd = end.hoursFrom(now)
            let daysFromBegin = begin.daysFrom(now)

            if (hoursFromEnd < -24) {
                return .Past

            } else if hoursFromEnd < 0 {
                return .NearPast

            } else if daysFromBegin < 3 {
                return .NearFuture

            } else if daysFromBegin < 7 {
                return .Future

            } else {
                return .DistantFuture
            }
        }
    }
}