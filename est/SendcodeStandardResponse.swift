//
//  StandardResponse.swift
//  EST
//
//  Created by Witsarut Suwanich on 8/19/15.
//  Copyright (c) 2015 Adapter Digital Co., Ltd. All rights reserved.
//

import Foundation

class SendcodeStandardResponse {
    
    var result: String
    var codelist: JSON
    
    init(result: String, codelist: JSON) {
        self.result = result
        self.codelist = codelist
    }
    
    class func getResponse(json: JSON) -> SendcodeStandardResponse {
        var result = json["result"].string
        var codelist = json["codelist"]
        return SendcodeStandardResponse(result: result!, codelist: codelist)
    }
    
}
