//
//  EstPopUpDetailView.swift
//  EST
//
//  Created by meow kling :3 on 9/1/2558 BE.
//  Copyright (c) 2558 Adapter Digital Co., Ltd. All rights reserved.
//

import UIKit

protocol EstPopUpDetailDelegate {
    func tapClosePopUp()
    func tapShareButton(isWinner: Bool)
}

class EstPopUpDetailView: UIView {

    @IBOutlet var view: UIView!
    @IBOutlet weak var popup: UIImageView!
    @IBOutlet weak var popup_winner_seat: UIImageView!
    @IBOutlet weak var popup_winner_phone: UIImageView!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var winnerLabel: UILabel!
    
    let keychain = KeychainUtility.keychainUtilityInstance
    var delegate: EstPopUpDetailDelegate?
    
    var textLabel: UILabel!
    var looserLabel: EstUILabel!
    
    var isWinner = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        NSBundle.mainBundle().loadNibNamed("EstPopUpDetailView", owner: self, options: nil)
        self.addSubview(self.view)
        self.view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        
        self.view.userInteractionEnabled = true
        
        self.winnerLabel.text = ""
        
        self.textLabel = UILabel(frame: CGRectMake(110, 174, 154, 21))
        self.textLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(self.textLabel)
        
        self.looserLabel = EstUILabel(frame: CGRectMake(107, 162, 42, 30))
        self.looserLabel.textAlignment = NSTextAlignment.Center
        self.looserLabel.font = UIFont(name: "DBHelvethaicaX-Med", size: 24)
        self.looserLabel.textColor = UIColor.whiteColor()
        self.view.addSubview(self.looserLabel)
        
        self.popup.hidden = true
        self.popup_winner_phone.hidden = true
        self.popup_winner_seat.hidden = true
        //self.shareButton.setImage(UIImage(named: "bt_share_facebook"), forState: UIControlState.Normal)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initEstPopUpDetailView(backgroundImage: UIImage, sharable: Bool) {
//        self.detailImage.image = backgroundImage
        self.popup.image = backgroundImage
       
        
        if(self.keychain.getObject("popup") == "winner_seat")  {
            self.popup_winner_seat.hidden = false
            self.popup_winner_seat.image = backgroundImage
            self.popup.hidden = true
            self.shareButton.hidden = false
        }else if (self.keychain.getObject("popup") == "winner_phone")   {
            self.popup_winner_phone.hidden = false
            self.popup_winner_phone.image = backgroundImage
            self.popup.hidden = true
            self.shareButton.hidden = false
        }else if (self.keychain.getObject("popup") == "loser")  {
            println("popup loser")
            self.popup.hidden = false
            self.popup.image = backgroundImage
            self.shareButton.hidden = true
            
            self.popup_winner_phone.hidden = true
            self.popup_winner_seat.hidden = true
        }else   {
            // popup thankyou
            self.popup_winner_seat.hidden = true
            self.popup_winner_phone.hidden = true
            println("popup thankyou")
            self.popup.hidden = false
            self.popup.image = backgroundImage
            self.shareButton.setImage(UIImage(named: "bt_sendcode_red_3"), forState: UIControlState.Normal)
            
            
            
        }
        
        
//        if (sharable) {
//            // show share button
//            self.shareButton.hidden = false
//            self.textLabel.hidden = false
//        } else {
//            // hide share button
//            self.shareButton.hidden = true
//            self.textLabel.hidden = true
//        }
    }
    
    @IBAction func tapShareButton(sender: AnyObject) {
        println("share")
        self.delegate?.tapShareButton(self.isWinner)
    }
    
    @IBAction func tapCloseButton(sender: AnyObject) {
        println("close")
        self.delegate?.tapClosePopUp()
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
