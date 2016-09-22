//
//  EstVideo.swift
//  est
//
//  Created by Witsarut Suwanich on 9/24/15.
//  Copyright (c) 2015 Adapter Digital Co., Ltd. All rights reserved.
//

import Foundation

class EstVideo {
    
    var name: String
    var videos: [EstVideoData]
    
    init(name: String, videos: [EstVideoData]) {
        self.name = name
        self.videos = videos
    }
    
    class func getEstVideo(json: JSON) -> EstVideo {
        var name = json["name"].string
        var vdos = [EstVideoData]()
        for (j, list: JSON) in json["list"] {
            var estVideoData = EstVideoData.getEstVideoData(list)
            vdos.append(estVideoData)
        }
        return EstVideo(name: name!, videos: vdos)
    }
}