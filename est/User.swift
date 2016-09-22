//
//  User.swift
//  est
//
//  Created by Witsarut Suwanich on 9/24/15.
//  Copyright (c) 2015 Adapter Digital Co., Ltd. All rights reserved.
//

import Foundation

class User {
    
    var name: String
    var fbuid: String
    var profilePic: String
    var profileURL: String
    var ticketCount: String
    var prizeList: [PrizeList]
    
    init(name: String, fbuid: String, profilePic: String, profileURL: String, ticketCount: String, prizeList: [PrizeList]) {
        self.name = name
        self.fbuid = fbuid
        self.profilePic = profilePic
        self.profileURL = profileURL
        self.ticketCount = ticketCount
        self.prizeList = prizeList
    }
    
    class func getUser(json: JSON) -> User {
        var name = json["name"].string
        var fbuid = json["fbuid"].string
        var profilePic = json["profilepic"].string
        var profileURL = json["profileurl"].string
        var ticketCount = json["ticketcount"].string
        var prizeList = [PrizeList]()
        for (index, pl: JSON) in json["data"] {
            prizeList.append(PrizeList.getPrizeList(pl))
        }
        return User(name: name!, fbuid: fbuid!, profilePic: profilePic!, profileURL: profileURL!, ticketCount: ticketCount!, prizeList: prizeList)
    }
    
}