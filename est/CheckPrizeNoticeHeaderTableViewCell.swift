//
//  CheckPrizeNoticeHeaderTableViewCell.swift
//  
//
//  Created by Apiwat Srisirisitthikul on 2/25/2559 BE.
//
//

import UIKit

class CheckPrizeNoticeHeaderTableViewCell: UITableViewCell {
    let ratio = UIScreen.mainScreen().bounds.size.height / UIScreen.mainScreen().bounds.size.width
    
    var imageView_Header: UIImageView?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if(ratio < 1.5)  {
            self.imageView_Header = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width/1.5, height: (UIScreen.mainScreen().bounds.size.width) * (147/765)))
            self.imageView_Header?.center = CGPointMake(UIScreen.mainScreen().bounds.size.width  / 2,UIScreen.mainScreen().bounds.size.width * (147/765) / 2 )
            self.imageView_Header?.image = UIImage(named: "winner_text_2")
            self.imageView_Header?.contentMode = UIViewContentMode.ScaleAspectFit
            self.contentView.addSubview(self.imageView_Header!)
        }else   {
            self.imageView_Header = UIImageView(frame: CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width/1.5, height: (UIScreen.mainScreen().bounds.size.width) * (147/765)))
            self.imageView_Header?.center = CGPointMake(UIScreen.mainScreen().bounds.size.width  / 2, UIScreen.mainScreen().bounds.size.width * (147/765) / 2 )
            self.imageView_Header?.image = UIImage(named: "winner_text_2")
            self.imageView_Header?.contentMode = UIViewContentMode.ScaleAspectFit
            self.contentView.addSubview(self.imageView_Header!)
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
