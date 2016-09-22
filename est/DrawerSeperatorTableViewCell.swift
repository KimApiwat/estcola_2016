//
//  DrawerSperatorTableViewCell.swift
//  EST
//
//  Created by meow kling :3 on 8/27/2558 BE.
//  Copyright (c) 2558 Adapter Digital Co., Ltd. All rights reserved.
//

import UIKit

class DrawerSeperatorTableViewCell: UITableViewCell {

    @IBOutlet weak var seperatorImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
