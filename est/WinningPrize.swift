//
//  WinningPrize.swift
//  EST
//
//  Created by Witsarut Suwanich on 8/19/15.
//  Copyright (c) 2015 Adapter Digital Co., Ltd. All rights reserved.
//

import Foundation

class WinningPrize {
    
    var type: String
    var mobile: String
    var code: String
    var winnerDate: String
    var winnerDateText: String
    var round: String
    var allRound: String
    
    init(type: String, mobile: String, code: String, winnerDate: String, winnerDateText: String, round: String, allRound: String) {
        self.type = type
        self.mobile = mobile
        self.code = code
        self.winnerDate = winnerDate
        self.winnerDateText = winnerDateText
        self.round = round
        self.allRound = allRound
    }
    
    class func getWinningPrize(json: JSON) -> WinningPrize {
        var type = json["type"].string
        var mobile = json["mobile"].string
        var code = json["code"].string
        var winnerDate = json["winnerdate"].string
        var winnerDateText = json["winnerdatetext"].string
        var round = json["round"].string
        var allRound = json["allround"].string
        return WinningPrize(type: type!, mobile: mobile!, code: code!, winnerDate: winnerDate!, winnerDateText: winnerDateText!, round: round!, allRound: allRound!)
    }
    
}
