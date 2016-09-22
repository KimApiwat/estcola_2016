//
//  TVCPopUpView.swift
//  est
//
//  Created by Witsarut Suwanich on 10/2/15.
//  Copyright (c) 2015 Adapter Digital Co., Ltd. All rights reserved.
//

import UIKit

protocol TVCPopUpViewDelegate {
    func tapTVCPopUpCloseButton()
}

class TVCPopUpView: UIView, YTPlayerViewDelegate {

    @IBOutlet var view: UIView!
    @IBOutlet var youtubePlayer: YTPlayerView!
    
    var webView: UIWebView!
    var delegate: TVCPopUpViewDelegate?
    
    let request = NSURLRequest(URL: NSURL(string: "http://estcolathai.com/promotion/app/clip.html")!)
    
    
    var youtube_url_id = ""
    override init(frame: CGRect) {
        super.init(frame: frame)
        NSBundle.mainBundle().loadNibNamed("TVCPopUpView", owner: self, options: nil)
//        NSBundle.mainBundle().loadNibNamed("TVCPopUpView~ipad", owner: self, options: nil)
        self.addSubview(self.view)
        self.view.frame = CGRectMake(0, 0, frame.size.width, frame.size.height)
        self.view.userInteractionEnabled = true
        
        var calsize = CGSizeMake(frame.size.width - 30, ((frame.size.width - 30) * 9) / 16)
        if (frame.size.width > 320) {
            self.webView = UIWebView(frame: CGRectMake((frame.size.width - calsize.width) / 2, ((frame.size.height - calsize.height) / 2) + 20, calsize.width, calsize.height))
        } else {
            self.webView = UIWebView(frame: CGRectMake((frame.size.width - calsize.width) / 2, ((frame.size.height - calsize.height) / 2) + 10, calsize.width, calsize.height))
        }
        
//        self.view.addSubview(self.webView)


        
        var playerVars:NSDictionary = [
            "autoplay" : 1,
        ]
        
//        println("youtube : \(self.youtube_url_id)")
        var keychain = KeychainUtility.keychainUtilityInstance
//        self.youtubePlayer.loadWithVideoId(keychain.getObject("youtube"))
        
        
        self.youtubePlayer.delegate = self
        self.youtubePlayer.loadWithVideoId(keychain.getObject("youtube"), playerVars: playerVars as [NSObject : AnyObject])
        self.playerViewDidBecomeReady(self.youtubePlayer)
        self.youtubePlayer.playVideo()
        self.view.addSubview(self.youtubePlayer)
        
    }
    
    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @IBAction func tapTVCPopUpCloseButton(sender: AnyObject) {
        self.delegate?.tapTVCPopUpCloseButton()
    }
    
    func playerViewDidBecomeReady(playerView: YTPlayerView!) {
        println("fuck")
        NSNotificationCenter.defaultCenter().postNotificationName("Playback started", object: self)
        self.youtubePlayer.playVideo()
    }
    
    
}
