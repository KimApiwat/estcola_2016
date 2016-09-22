//
//  EstUILabel.swift
//  est
//
//  Created by Witsarut Suwanich on 9/20/15.
//  Copyright (c) 2015 Adapter Digital Co., Ltd. All rights reserved.
//

import UIKit

class EstUILabel: UILabel {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    override func drawTextInRect(rect: CGRect) {
        var shadowOffset = self.shadowOffset
        var textColor = self.textColor
        
        var c = UIGraphicsGetCurrentContext()
        CGContextSetLineWidth(c, 7)
        CGContextSetLineJoin(c, kCGLineJoinRound)
        
        CGContextSetTextDrawingMode(c, kCGTextStroke)
        self.textColor = UIColor(red: 0.03, green: 0.14, blue: 0.26, alpha: 1.0)
        
        super.drawTextInRect(rect)
        
        CGContextSetTextDrawingMode(c, kCGTextFill)
        self.textColor = UIColor.whiteColor()
        self.shadowOffset = CGSizeMake(0, 0)
        super.drawTextInRect(rect)
        
        self.shadowOffset = shadowOffset
    }

}