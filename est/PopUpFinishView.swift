//
//  PopUpFinishView.swift
//  est
//
//  Created by Witsarut Suwanich on 10/1/15.
//  Copyright (c) 2015 Adapter Digital Co., Ltd. All rights reserved.
//

import UIKit

protocol PopUpFinishViewDelegate {
    func tapPopUpFinishCloseButton()
}

class PopUpFinishView: UIView {
    
    var delegate: PopUpFinishViewDelegate?

    @IBOutlet var view: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        NSBundle.mainBundle().loadNibNamed("PopUpFinishView", owner: self, options: nil)
        self.addSubview(self.view)
        self.view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        self.view.userInteractionEnabled = true
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction func tapPopUpFinishCloseButton(sender: AnyObject) {
        self.delegate?.tapPopUpFinishCloseButton()
    }
    
    @IBAction func tapFanPageButton(sender: AnyObject) {
        UIApplication.sharedApplication().openURL(NSURL(string: "https://www.facebook.com/estcola")!)
    }
}
