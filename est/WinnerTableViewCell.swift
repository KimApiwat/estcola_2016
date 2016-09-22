//
//  WinnerTableViewCell.swift
//  est
//
//  Created by Witsarut Suwanich on 9/20/15.
//  Copyright (c) 2015 Adapter Digital Co., Ltd. All rights reserved.
//

import UIKit

class WinnerTableViewCell: UITableViewCell {

    @IBOutlet weak var announceImageView: UIImageView!
    @IBOutlet weak var announceLabel: UILabel!
    @IBOutlet weak var prizeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        /*self.announceLabel.attributedText = NSAttributedString(string: "ประกาศครั้งที่ 1", attributes: [
            NSStrokeWidthAttributeName: -1.0,
            NSStrokeColorAttributeName: UIColor.redColor(),
            NSForegroundColorAttributeName: UIColor.whiteColor()
        ])*/
        self.backgroundColor = EstColors.MAIN_BLUE_COLOR
        self.selectionStyle = UITableViewCellSelectionStyle.None
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
