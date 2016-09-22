//
//  CodeTableViewCell.swift
//  EST
//
//  Created by meow kling :3 on 8/31/2558 BE.
//  Copyright (c) 2558 Adapter Digital Co., Ltd. All rights reserved.
//

import UIKit

class CodeTableViewCell: UITableViewCell {

    @IBOutlet weak var codeIcon: UIImageView!
    @IBOutlet weak var codeNumber: UILabel!
    @IBOutlet weak var codeTextField: UITextField!
    
    @IBOutlet weak var imageview_curve_r: UIImageView!
    @IBOutlet weak var imageview_center: UIImageView!
    @IBOutlet weak var imageview_curve: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.codeNumber.hidden = true
//        var bg = UIView()
//        bg.backgroundColor = UIColor.clearColor()
//        self.selectedBackgroundView = bg
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
