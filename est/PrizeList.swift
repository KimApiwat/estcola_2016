//
//  PrizeList.swift
//  est
//
//  Created by Witsarut Suwanich on 9/24/15.
//  Copyright (c) 2015 Adapter Digital Co., Ltd. All rights reserved.
//

import Foundation

class PrizeList {
    
    var date: String
    var prizes: [Prize]
    
    init(date: String, prizes: [Prize]) {
        self.date = date
        self.prizes = prizes
    }
    
    class func getPrizeList(json: JSON) -> PrizeList {
        var date = json["date"].string
        var prizes = [Prize]()
        for (index, prize: JSON) in json["prize"] {
            prizes.append(Prize.getPrize(prize))
        }
        return PrizeList(date: date!, prizes: prizes)
    }
}