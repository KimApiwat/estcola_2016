//
//  CheckPrizeDetailTextTableViewCell.swift
//  
//
//  Created by Apiwat Srisirisitthikul on 2/25/2559 BE.
//
//

import UIKit

class CheckPrizeDetailTextTableViewCell: UITableViewCell {
    let ratio = UIScreen.mainScreen().bounds.size.height / UIScreen.mainScreen().bounds.size.width
    
    var imageView_DetailText: UIImageView?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        if(ratio < 1.5)  {
            self.imageView_DetailText = UIImageView(frame: CGRect(x: 110, y: 3, width: UIScreen.mainScreen().bounds.size.width - 220, height: (UIScreen.mainScreen().bounds.size.width - 220) * (148/804)))
            self.imageView_DetailText?.image = UIImage(named: "winner_text_1")
            self.imageView_DetailText?.contentMode = UIViewContentMode.ScaleAspectFit
            self.contentView.addSubview(self.imageView_DetailText!)
        }else   {
            self.imageView_DetailText = UIImageView(frame: CGRect(x: 14, y: 3, width: UIScreen.mainScreen().bounds.size.width - 35, height: (UIScreen.mainScreen().bounds.size.width - 35) * (148/804)))
            self.imageView_DetailText?.image = UIImage(named: "winner_text_1")
            self.imageView_DetailText?.contentMode = UIViewContentMode.ScaleAspectFit
            self.contentView.addSubview(self.imageView_DetailText!)
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
