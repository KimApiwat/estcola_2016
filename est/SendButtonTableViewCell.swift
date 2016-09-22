//
//  SendButtonTableViewCell.swift
//  EST
//
//  Created by meow kling :3 on 8/31/2558 BE.
//  Copyright (c) 2558 Adapter Digital Co., Ltd. All rights reserved.
//

import UIKit

protocol SendButtonTableViewCellDelegate {
    func tapSendButton()
}

class SendButtonTableViewCell: UITableViewCell {
    
    @IBOutlet weak var sendButton: UIButton!
    
    var delegate: SendButtonTableViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func tapSendButton(sender: AnyObject) {
        self.delegate?.tapSendButton()
    }
    
}
