//
//  MenuDisclosureCell.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 6/11/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

class MenuDisclosureCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
}
