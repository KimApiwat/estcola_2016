//
//  EstColarNavigationBar.swift
//  EST
//
//  Created by meow kling :3 on 8/28/2558 BE.
//  Copyright (c) 2558 Adapter Digital Co., Ltd. All rights reserved.
//

import UIKit

class EstColarNavigationBar: UINavigationBar {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var navigationItem = self.topItem
        if let subview = navigationItem?.leftBarButtonItem?.customView {
            subview.frame = CGRectMake(-20, 0, subview.frame.size.width, subview.frame.size.height)
            subview.bounds = CGRectMake(-20, 0, subview.frame.size.width, subview.frame.size.height)
        }
        
    }

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
