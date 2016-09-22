//
//  EstApplication.swift
//  EST
//
//  Created by meow kling :3 on 8/31/2558 BE.
//  Copyright (c) 2558 Adapter Digital Co., Ltd. All rights reserved.
//

import Foundation

class EstApplication {
    
    let MAIN_BLUE_COLOR = UIColor(red: 53, green: 113, blue: 188, alpha: 1.0)
    static let MONTH = [
        8: "สิงหาคม",
        9: "กันยายน",
        10: "ตุลาคม",
        11: "พฤศจิกายน",
        12: "ธันวาคม"
    ]
    
    
    
    
    
    static let TVC_URL = "http://estcolathai.com/promotion/app/clip.html"
    static let RULE_URL = "http://estcolathai.com/promotion/app/rule.html"
    static let HOWTO_URL = "http://estcolathai.com/promotion/app/howto.html"
    
    static let GAME_RULE_URL = "http://estcolathai.com/activity/app/rule.aspx"
    static let GAME_WINNER_URL = "http://estcolathai.com/activity/app/winner.aspx"
    
    
//    static let estThaiMobileTracker: GAITracker = GAI.sharedInstance().trackerWithTrackingId("UA-66731261-2")
    static let estPromoCodeTracker: GAITracker = GAI.sharedInstance().trackerWithTrackingId("UA-66731261-6")
//    static let estPromoGameTracker: GAITracker = GAI.sharedInstance().trackerWithTrackingId("UA-66731261-4")
    
    class func getNotiIconImage() {
        let keychain = KeychainUtility.keychainUtilityInstance
        var winners = [Winner]()
        var estHTTPService = ESTHTTPService.estHTTPServiceInstance
        println("get noti icon image")
        var request = estHTTPService.getWinnerList(Callback() { (response, success, errorString, error) in
            println("**********")
            if let err: NSError = error {
                println(err.localizedDescription)
            }
            if (success) {
                println("get winner")
                if let wnrs = response {
                    winners = wnrs
                    for var i = winners.count - 1; i >= 0; i-- {
                        if (winners[i].status == "true") {
                            if (keychain.getObject("is_open_winner_list_\(winners[i].winner)") != "") {
                                keychain.setObject("notiicon", value: "notiblack_\(winners[i].winner)")
                            } else {
                                keychain.setObject("notiicon", value: "notired_\(winners[i].winner)")
                            }
                        }
                    }
                }
            } else {
                // error
                // keychain.setObject("notiicon", value: "noti_icon")
            }
        })
    }
    
    
    class func getNoti()    {
        let keychain = KeychainUtility.keychainUtilityInstance
        var estHTTPService = ESTHTTPService.estHTTPServiceInstance
        
        var request = estHTTPService.getAlertData(Callback() { (responseString,success, _, error)   in
            if(success) {
                if let x :String = responseString   {
                    println("notiicon : \(x)")
                    keychain.setObject("announce", value: x)
                    if(x == "0") {
                         keychain.setObject("notiicon", value: "noti_icon")
                    } else {
//                        var x = keychain.getObject("is_open_winner_list_\(x)")
                        if (keychain.getObject("is_open_winner_list_\(x)") != "") {
                            keychain.setObject("notiicon", value: "noti_black_\(x)")
                        } else {
                            println("*********************")
                            keychain.setObject("notiicon", value: "noti_red_\(x)")
                        }
                        NSNotificationCenter.defaultCenter().postNotificationName("updatenotiicon", object: nil)
                    }
                }
                
            }else   {
                // error
                println("fucking error")
                //keychain.setObject("notiicon", value: "noti_icon")
            }
        })
    }
    
    
    class func setAppData() {
        var estHTTPService = ESTHTTPService.estHTTPServiceInstance
        let keychain = KeychainUtility.keychainUtilityInstance
        var request = estHTTPService.getApplicationDataInfo(Callback()   { (json,success,errorSring,error) in
            if(success) {
                if let data = json {
                    println("66666666666666666666666666666666666")
                    println(data)
                    var app_info = AppInfo.getAppInfo(data)
                    println("app_info : \(app_info.youtube)")
                    keychain.setObject("youtube", value: app_info.youtube)
                    keychain.setObject("share_url", value: app_info.share_url)
                    keychain.setObject("share_title", value: app_info.share_title)
                    keychain.setObject("share_description", value: app_info.share_description)
                    keychain.setObject("share_image", value: app_info.share_image)
                    keychain.setObject("page_url", value: app_info.page_url)
                    keychain.setObject("page_rule", value: app_info.page_rule)
                    keychain.setObject("page_how_to", value: app_info.page_how_to)
                    keychain.setObject("_end_", value: app_info.end)
                    
                }
            }
            })
    }
    
    
    
    
}