//
//  CheckPrizeButtonTableViewCell.swift
//  EST
//
//  Created by meow kling :3 on 9/1/2558 BE.
//  Copyright (c) 2558 Adapter Digital Co., Ltd. All rights reserved.
//

import UIKit

protocol CheckPrizeButtonDelegate {
    func tapCheckPrizeButton()
}

class CheckPrizeButtonTableViewCell: UITableViewCell {

    var delegate: CheckPrizeButtonDelegate?
    
    @IBOutlet weak var button_checkprize: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tapCheckPrizeButton(sender: AnyObject) {
        self.delegate?.tapCheckPrizeButton()
    }
    
}
