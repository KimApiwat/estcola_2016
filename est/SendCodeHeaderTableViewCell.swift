//
//  SendCodeHeaderTableViewCell.swift
//  EST
//
//  Created by meow kling :3 on 8/31/2558 BE.
//  Copyright (c) 2558 Adapter Digital Co., Ltd. All rights reserved.
//

import UIKit

class SendCodeHeaderTableViewCell: UITableViewCell {
    let ratio = UIScreen.mainScreen().bounds.size.height / UIScreen.mainScreen().bounds.size.width
    
    var imageView_Header: UIImageView?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        /*self.frame = CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.width * (1080/1242))
        var headerView = UIImageView(frame: CGRectMake(0, 0, UIScreen.mainScreen().bounds.size.width, UIScreen.mainScreen().bounds.size.width * (1080/1242)))
        headerView.image = UIImage(named: "header_sendcode")*/
//        headerView.backgroundColor = EstColors.MAIN_BLUE_COLOR
        //self.addSubview(headerView)
        self.selectedBackgroundView = UIView()
        // w, w*h/w
        if(ratio < 1.5)  {
            self.imageView_Header = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: (UIScreen.mainScreen().bounds.size.width) * (705/1080)))
            self.imageView_Header?.image = UIImage(named: "sendcode_header")
            self.imageView_Header?.contentMode = UIViewContentMode.ScaleAspectFit
            self.contentView.addSubview(self.imageView_Header!)
        }else   {
            self.imageView_Header = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: (UIScreen.mainScreen().bounds.size.width) * (705/1080)))
            self.imageView_Header?.image = UIImage(named: "sendcode_header")
            self.imageView_Header?.contentMode = UIViewContentMode.ScaleAspectFit
            self.contentView.addSubview(self.imageView_Header!)
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
