//
//  MenuCategoryCell.swift
//  CPT331.iOS
//
//  Created by Peter Weller on 20/10/2016.
//  Copyright © 2016 Peter Weller. All rights reserved.
//

import UIKit

class MenuCategoryCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var selectionImage: UIImageView!
    
    internal let imageState = (deslected: UIImage(named: "Icon-Deselected.png"), selected: UIImage(named: "Icon-Selected.png"))
    
    var category:EventCategory?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }
    
    func update() {
        guard let category = self.category else {
            self.nameLabel.text = ""
            self.selectionImage.image = imageState.deslected
            return
        }
        
        self.nameLabel.text = category.name
        
        if self.selected {
            self.selectionImage.image = imageState.selected?.tintWithColor(category.color)
        } else {
            self.selectionImage.image = imageState.deslected?.tintWithColor(category.color)
        }
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.update()
    }
}
