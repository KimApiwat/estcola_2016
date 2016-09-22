//
//  DrawerTableViewCell.swift
//  EST
//
//  Created by meow kling :3 on 8/27/2558 BE.
//  Copyright (c) 2558 Adapter Digital Co., Ltd. All rights reserved.
//

import UIKit

class DrawerTableViewCell: UITableViewCell {

    @IBOutlet weak var drawerIcon: UIImageView!
    @IBOutlet weak var drawerNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
//        self.drawerNameLabel.layer.shadowOffset = CGSizeMake(0.7, 0.7)
//        self.drawerNameLabel.layer.shadowOpacity = 0.7
        var bg = UIView()
        bg.backgroundColor = UIColor.clearColor()
        self.selectedBackgroundView = bg
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
