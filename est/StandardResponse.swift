//
//  StandardResponse.swift
//  EST
//
//  Created by Witsarut Suwanich on 8/19/15.
//  Copyright (c) 2015 Adapter Digital Co., Ltd. All rights reserved.
//

import Foundation

class StandardResponse {
    
    var result: String
    var detail: String?
    
    init(result: String, detail: String?) {
        self.result = result
        self.detail = detail
    }
    
    class func getResponse(json: JSON) -> StandardResponse {
        var result = json["result"].string
        var detail = json["detail"].string
        return StandardResponse(result: result!, detail: detail)
    }
    
}
