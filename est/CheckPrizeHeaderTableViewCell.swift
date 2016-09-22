//
//  CheckPrizeHeaderTableViewCell.swift
//  EST
//
//  Created by meow kling :3 on 9/1/2558 BE.
//  Copyright (c) 2558 Adapter Digital Co., Ltd. All rights reserved.
//

import UIKit

class CheckPrizeHeaderTableViewCell: UITableViewCell {
    let ratio = UIScreen.mainScreen().bounds.size.height / UIScreen.mainScreen().bounds.size.width
    
    var imageView_Header: UIImageView?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        /*self.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.width * (1415/1242))
        var headerView = UIImageView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.width * (1415/1242)))
        headerView.image = UIImage(named: "header_check")
        self.addSubview(headerView)*/
        if(ratio < 1.5)  {
            self.imageView_Header = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: (UIScreen.mainScreen().bounds.size.width) * (415/1080)))
            self.imageView_Header?.image = UIImage(named: "winner_header")
            self.imageView_Header?.contentMode = UIViewContentMode.ScaleAspectFit
            self.contentView.addSubview(self.imageView_Header!)
        }else   {
            self.imageView_Header = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: (UIScreen.mainScreen().bounds.size.width) * (415/1080)))
            self.imageView_Header?.image = UIImage(named: "winner_header")
            self.imageView_Header?.contentMode = UIViewContentMode.ScaleAspectFit
            self.contentView.addSubview(self.imageView_Header!)
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
