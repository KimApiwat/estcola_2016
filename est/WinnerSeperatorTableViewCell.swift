//
//  WinnerSeperatorTableViewCell.swift
//  est
//
//  Created by Witsarut Suwanich on 9/21/15.
//  Copyright (c) 2015 Adapter Digital Co., Ltd. All rights reserved.
//

import UIKit

class WinnerSeperatorTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = EstColors.MAIN_BLUE_COLOR
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
