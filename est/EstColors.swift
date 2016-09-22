//
//  EstColors.swift
//  EST
//
//  Created by meow kling :3 on 8/31/2558 BE.
//  Copyright (c) 2558 Adapter Digital Co., Ltd. All rights reserved.
//

import Foundation

class EstColors {
    
    static let MAIN_BLUE_COLOR = UIColor(red: 53/255, green: 113/255, blue: 188/255, alpha: 1.0)
    
    class var estColorsInstance: EstColors {
        struct Static {
            static let instance: EstColors = EstColors()
        }
        return Static.instance
    }
    
}
