//
//  DetailTextTableViewCell.swift
//  EST
//
//  Created by meow kling :3 on 8/31/2558 BE.
//  Copyright (c) 2558 Adapter Digital Co., Ltd. All rights reserved.
//

import UIKit

class DetailTextTableViewCell: UITableViewCell {
    
    let ratio = UIScreen.mainScreen().bounds.size.height / UIScreen.mainScreen().bounds.size.width

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if (ratio < 1.5) {
            var calsize = CGSizeMake(UIScreen.mainScreen().bounds.size.width - 220, (UIScreen.mainScreen().bounds.size.width - 220) * (253/1092))
            self.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.width * (253/1092))
            var detailView = UIImageView(frame: CGRectMake((UIScreen.mainScreen().bounds.size.width - (calsize.width * 0.8)) / 2, 15, calsize.width * 0.8, calsize.height * 0.8))
            detailView.image = UIImage(named: "text_1")
            self.addSubview(detailView)
        } else {
            self.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.width * (253/1092))
            var detailView = UIImageView(frame: CGRectMake(14, 3, UIScreen.mainScreen().bounds.size.width - 35, (UIScreen.mainScreen().bounds.size.width - 35) * (253/1092)))
            detailView.image = UIImage(named: "text_1")
            self.addSubview(detailView)
        }
        
//        detailView.backgroundColor = EstColors.MAIN_BLUE_COLOR
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
