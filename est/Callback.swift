//
//  Callback.swift
//  EST
//
//  Created by meow kling :3 on 9/1/2558 BE.
//  Copyright (c) 2558 Adapter Digital Co., Ltd. All rights reserved.
//

import Foundation

class Callback<T> {
    
    var callback: (T?, Bool, String?, NSError?) -> Void
    
    required init(callback: (T?, Bool, String?, NSError?) -> Void) {
        self.callback = callback
    }
    
}