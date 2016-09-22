//
//  Winner.swift
//  EST
//
//  Created by Witsarut Suwanich on 8/19/15.
//  Copyright (c) 2015 Adapter Digital Co., Ltd. All rights reserved.
//

import Foundation

class Winner {
    
    var winner: String
    var date: String
    var prize: String
    var status: String
    var url: String
    
    init(winner: String, date: String, prize: String, status: String, url: String) {
        self.winner = winner
        self.date = date
        self.prize = prize
        self.status = status
        self.url = url
    }
    
    class func getWinner(json: JSON) -> Winner {
        var winner = json["winner"].string
        var date = json["date"].string
        var prize = json["prize"].string
        var status = json["status"].string
        var url = json["url"].string
        
        var dateSplit = date!.split("-")
        var year = dateSplit[0]
        var day = dateSplit[2]
        var dateText = ""
        if let month = EstApplication.MONTH[dateSplit[1].toInt()!] {
            dateText = "\(day) \(month) \(year)"
        }
        
        return Winner(winner: winner!, date: dateText, prize: prize!, status: status!, url: url!)
    }
    
}
