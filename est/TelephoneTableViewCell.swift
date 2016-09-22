//
//  TelephoneTableViewCell.swift
//  EST
//
//  Created by meow kling :3 on 8/31/2558 BE.
//  Copyright (c) 2558 Adapter Digital Co., Ltd. All rights reserved.
//

import UIKit

class TelephoneTableViewCell: UITableViewCell {

    @IBOutlet weak var telTextField: UITextField!
    @IBOutlet weak var imageview_signcorrect: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
