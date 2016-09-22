//
//  AddMoreTableViewCell.swift
//  EST
//
//  Created by meow kling :3 on 8/31/2558 BE.
//  Copyright (c) 2558 Adapter Digital Co., Ltd. All rights reserved.
//

import UIKit

protocol AddMoreTableCellDelegate {
    func tapAddMoreButton()
}

class AddMoreTableViewCell: UITableViewCell {
    
    @IBOutlet weak var button: UIButton!
    
    var delegate: AddMoreTableCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tapAddMoreButton(sender: AnyObject) {
        self.delegate?.tapAddMoreButton()
    }
    
}
