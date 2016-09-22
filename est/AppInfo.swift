//
//  AppInfo.swift
//  est
//
//  Created by Apiwat Srisirisitthikul on 3/4/2559 BE.
//  Copyright (c) 2559 Adapter Digital Co., Ltd. All rights reserved.
//

import Foundation
class AppInfo {
    
    var youtube: String
    
    var share_url: String
    var share_title: String
    var share_description: String
    var share_image: String
    
    var page_url: String
    var page_how_to: String
    var page_rule: String
    var end : String
    

    
    init(youtubex: String,
        share_urlx: String,
        share_titlex: String,
        share_descriptionx: String,
        share_imagex: String,
        page_urlx: String,
        page_how_tox: String,
        page_rulex: String,
        endx: String) {
            
            self.youtube = youtubex
            
            self.share_url = share_urlx
            self.share_title = share_titlex
            self.share_description = share_descriptionx
            self.share_image = share_imagex
            
            self.page_url = page_urlx
            self.page_how_to = page_how_tox
            self.page_rule = page_rulex
            self.end = endx
            
            
    }
    
    class func getAppInfo(json: JSON) -> AppInfo {
        var youtube = json["youtube"].string
        
        var share_url = json["share_url"].string
        var share_title = json["share_title"].string
        var share_description = json["share_description"].string
        var share_image = json["share_image"].string
        
        var page_url = json["page_url"].string
        var page_how_to = json["page_how_to"].string
        var page_rule = json["page_rule"].string
        var end = json["_end_"].string
        
        return AppInfo(youtubex: youtube!, share_urlx: share_url!, share_titlex: share_title!, share_descriptionx: share_description!, share_imagex: share_image!, page_urlx: page_url!, page_how_tox: page_how_to!, page_rulex: page_rule!, endx: end!)
        
        
    }
    
}