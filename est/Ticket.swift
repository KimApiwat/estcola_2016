//
//  Ticket.swift
//  est
//
//  Created by Witsarut Suwanich on 9/23/15.
//  Copyright (c) 2015 Adapter Digital Co., Ltd. All rights reserved.
//

import Foundation

class Ticket {

    var id: String
    
    init(id: String) {
        self.id = id
    }
    
    class func getTicket(json: JSON) -> Ticket {
        var id = json["id"].string
        return Ticket(id: id!)
    }
    
}