//
//  LocationEventsListCell.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 22/09/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

class EventsListCell: UITableViewCell {
    
    @IBOutlet weak var primaryLabel: UILabel!
    @IBOutlet weak var secondaryLabel: UILabel!

    @IBOutlet weak var relativeTimeLabel: UILabel!
    @IBOutlet weak var fixedTimeLabel: UILabel!

    @IBOutlet weak var thumbnailView: UIImageView!
    
    var event:Event!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = UIColor.clearColor()
    }
    
    func update() {
        // Rendering mode set so a tint color can be specified
        self.thumbnailView.image = event.subcategory.image?.imageWithRenderingMode(.AlwaysTemplate)
        self.thumbnailView.tintColor = event.category.color

        self.primaryLabel.text = event.name
        self.secondaryLabel.text = event.subcategory.name

        let type = EventSectionType.type(forEvent: self.event)

        // Relative time label
        if type == .Current {
            let timeUntilEnd = NSDateComponents.fromRange(NSDate(), event.endDateTime!)
            self.relativeTimeLabel.text = timeUntilEnd.string

        } else if type == .Soon {
            let timeUntilBegin = NSDateComponents.fromRange(NSDate(), event.beginDateTime!)
            self.relativeTimeLabel.text = timeUntilBegin.string

        } else if type == .NearFuture && event.beginDateTime!.isTomorrow() {
            self.relativeTimeLabel.text = "Tomorrow"

        } else if type == .NearFuture || type == .Future {
            self.relativeTimeLabel.text = event.beginDateTime?.toString("EEEE")

        } else {
            self.relativeTimeLabel.text = event.beginDateTime?.toString("MMM d")
        }

        // Fixed time label
        if type == .Current {
            self.fixedTimeLabel.text = "Until end"
        } else {
            self.fixedTimeLabel.text = event.beginDateTime?.toString("h:mm a")
        }

    }
}