//
//  HomeTableViewCell.swift
//  
//
//  Created by Apiwat Srisirisitthikul on 2/19/2559 BE.
//
//

import UIKit
protocol SendCodeButtonTableViewCellDelegate    {
    func tapSendCodeButton()
}
class HomeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var button_sendcode: UIButton!
    var delegate:SendCodeButtonTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        var bg = UIView()
        bg.backgroundColor = UIColor.clearColor()
        self.selectedBackgroundView = bg
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func tapSendCodeButton(sender: AnyObject) {
        self.delegate?.tapSendCodeButton()
    }
}
