//
//  EstUILabelRedStroke.swift
//  est
//
//  Created by Witsarut Suwanich on 9/30/15.
//  Copyright (c) 2015 Adapter Digital Co., Ltd. All rights reserved.
//

import Foundation

class EstUILabelRedStroke: UILabel {

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
        CGContextSetLineWidth(c, 5)
        CGContextSetLineJoin(c, kCGLineJoinRound)
        
        CGContextSetTextDrawingMode(c, kCGTextStroke)
        self.textColor = UIColor.redColor()
        
        super.drawTextInRect(rect)
        
        CGContextSetTextDrawingMode(c, kCGTextFill)
        self.textColor = UIColor.whiteColor()
        self.shadowOffset = CGSizeMake(0, 0)
        super.drawTextInRect(rect)
        
        self.shadowOffset = shadowOffset
    }

}