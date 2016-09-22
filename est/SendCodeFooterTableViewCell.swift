//
//  SendCodeFooterTableViewCell.swift
//  
//
//  Created by Apiwat Srisirisitthikul on 2/27/2559 BE.
//
//

import UIKit

class SendCodeFooterTableViewCell: UITableViewCell {

    @IBOutlet weak var label_footer: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.label_footer.font = UIFont(name: "DB Helvethaica X", size: 15.0)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
