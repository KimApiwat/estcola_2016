//
//  Prize.swift
//  est
//
//  Created by Witsarut Suwanich on 9/24/15.
//  Copyright (c) 2015 Adapter Digital Co., Ltd. All rights reserved.
//

import Foundation

class Prize {
    
    var item: String
    var desc: String
    var count: String
    var unit: String
    
    init(item: String, desc: String, count: String, unit: String) {
        self.item = item
        self.desc = desc
        self.count = count
        self.unit = unit
    }
    
    class func getPrize(json: JSON) -> Prize {
        var item = json["item"].string
        var desc = json["desc"].string
        var count = json["count"].string
        var unit = json["unit"].string
        return Prize(item: item!, desc: desc!, count: count!, unit: unit!)
    }
    
}
