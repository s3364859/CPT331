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
    
    var event:Event!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func update() {
        self.primaryLabel.text = event.name
        self.secondaryLabel.text = "Categories [NYI]"
    }
}