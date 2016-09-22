//
//  EstVideoData.swift
//  est
//
//  Created by Witsarut Suwanich on 9/24/15.
//  Copyright (c) 2015 Adapter Digital Co., Ltd. All rights reserved.
//

import Foundation

class EstVideoData{
    
    var version: String
    var screen: String
    var url: String
    
    init(version: String, screen: String, url: String) {
        self.version = version
        self.screen = screen
        self.url = url
    }
    
    class func getEstVideoData(json: JSON) -> EstVideoData {
        var version = json["ver"].string
        var screen = json["screen"].string
        var url = json["url"].string
        return EstVideoData(version: version!, screen: screen!, url: url!)
    }
    
    
}