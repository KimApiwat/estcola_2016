//
//  ESTHTTPService.swift
//  EST
//
//  Created by Witsarut Suwanich on 8/19/15.
//  Copyright (c) 2015 Adapter Digital Co., Ltd. All rights reserved.
//

import Foundation

class ESTHTTPService {
    // https://www.estcolathai.com/promotion/api/mobile/appactive.aspx
    
    let APP_INFO_URL = "http://www.estcolathai.com/promotion/api/mobile/mobileapp_getDataInfo.aspx"
    
    let SENDCODE_BASE_URL = "http://www.estcolathai.com/promotion/api/mobile"
    
    let SEND_CODE = "http://www.estcolathai.com/promotion/api/mobile/mobileapp_sendcode.aspx"
    
    let GET_WINNER_BY_MOBILE_NUMBER = "http://www.estcolathai.com/promotion/api/mobile/mobileapp_checkwinner.aspx"
    let GET_WINNER_LIST = "http://www.estcolathai.com/promotion/api/mobile/mobileapp_getWinnerAnnounce.aspx"
    
    let ALERT_DATA_URL = "http://www.estcolathai.com/promotion/api/mobile/mobileapp_alertData.aspx"
    
    let keychain = KeychainUtility.keychainUtilityInstance
    
    class var estHTTPServiceInstance: ESTHTTPService {
        struct Static {
            static let instance: ESTHTTPService = ESTHTTPService()
        }
        return Static.instance
    }
    
    func sendCode(mobileno: String, codes: [String], cb: Callback<SendcodeStandardResponse>) -> Request {
        var parameters = Dictionary<String, AnyObject>()
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        var manager = Manager.sharedInstance
        
        parameters["mobileno"] = mobileno
        parameters["caller"] = "json"
        
        var resultCodes = ""
        for code in codes {
            resultCodes += "\(code)|"
        }
        
        resultCodes.removeAtIndex(resultCodes.endIndex.predecessor())
        parameters["code"] = resultCodes
        
        return manager.request(.POST, self.SEND_CODE, parameters: parameters).responseJSON { (request, response, jsonData, error) in
            if let data: AnyObject = jsonData {
                var json = JSON(data)
                if (json["result"].string == "complete") {
                    println(json["codelist"])
                    var sendcodeStandardResponse = SendcodeStandardResponse.getResponse(json)
//                    println(sendcodeStandardResponse.codelist[0])
//                    var standardResponse = StandardResponse.getResponse(json)
//                    println(standardResponse.result)
                    cb.callback(sendcodeStandardResponse, true, nil, nil)
                } else {
                    cb.callback(nil, false, json["result"].string, error)
                }
            } else {
                cb.callback(nil, false, nil, error)
            }
        }
    }
    
    func getAlertData(cb: Callback<String>) -> Request    {
        var parameters = Dictionary<String, AnyObject>()
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        var manager = Manager.sharedInstance
        
        parameters["caller"] = "json"
        
        return manager.request(.GET, self.ALERT_DATA_URL, parameters: parameters).responseJSON { (request, response, responseString, error) in
            println("response string: \(responseString)")
//            var data1 = JSON(responseString!)
            if let data: AnyObject = responseString {
                var json = JSON(data)
                cb.callback(json["detail"].string,true,nil,nil)
            }else   {
                cb.callback(nil, false, nil, error)
            }
    
        }
    }
    
    
    
    func getWinnerByMobileNumber(mobileno: String, cb: Callback<JSON>) -> Request {
        var parameters = Dictionary<String, AnyObject>()
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        var manager = Manager.sharedInstance
        
        parameters["mobileno"] = mobileno
        parameters["caller"] = "json"
        
        return manager.request(.POST, self.GET_WINNER_BY_MOBILE_NUMBER, parameters: parameters).responseJSON { (request, response, jsonData, error) in
            if let data: AnyObject = jsonData {
                var json = JSON(data)
                println("json : \(json)")
                cb.callback(json, true, nil, nil)
            } else {
                cb.callback(nil, false, nil, error)
            }
        }

    }
    
    func getApplicationDataInfo(cb: Callback<JSON>) -> Request {
        return request(.GET, self.APP_INFO_URL)
            .responseJSON { (_, _, jsonData, error) in
                if let data: AnyObject = jsonData {
                    var json = JSON(data)
                    println(json)
//                    var winners = [Winner]()
//                    var app_info = AppInfo.getAppInfo(json)
                    cb.callback(json, true, nil, nil)
                } else {
                    cb.callback(nil, false, nil, error)
                }
        }
    }
    
    
    
    func getWinnerList(cb: Callback<[Winner]>) -> Request {
        return request(.GET, self.GET_WINNER_LIST)
            .responseJSON { (_, _, jsonData, error) in
                if let data: AnyObject = jsonData {
                    var json = JSON(data)
                    println(json)
                    var winners = [Winner]()
                    for (index, winner: JSON) in json["data"] {
                        let winner = Winner.getWinner(winner)
                        winners.append(winner)
                    }
                    cb.callback(winners, true, nil, nil)
                } else {
                    cb.callback(nil, false, nil, error)
                }
        }
    }
    
    
    
    
    
    
    func sendEstThaiMobileTracker(category: String, action: String, label: String) {
        var builder = GAIDictionaryBuilder.createEventWithCategory(
                category,
                action: action,
                label: label,
                value: nil)
    }
    
    func sendEstPromoCodeTracker(category: String, action: String, label: String) {
        var builder = GAIDictionaryBuilder.createEventWithCategory(
                category,
                action: action,
                label: label,
                value: nil)
        EstApplication.estPromoCodeTracker.send(builder.build() as [NSObject : AnyObject])
        print("cat \(category)")
    }
    
    
    func sendOpenAppSendCodeState() {
        var url = self.SENDCODE_BASE_URL + "/applicationstatlog.aspx"
        
        var parameters = Dictionary<String, AnyObject>()
        parameters["stat"] = "estcolapromo"
        parameters["param1"] = "ios"
        parameters["param2"] = "openapp"
        
        request(.GET, url, parameters: parameters)
    }

//    func sendOpenGameState() {
//        var url = self.GAME_BASE_URL + "/applicationstatlognoua.aspx"
//        
//        var parameters = Dictionary<String, AnyObject>()
//        parameters["stat"] = "estunexpected"
//        parameters["param1"] = "ios"
//        parameters["param2"] = "openapp"
//        
//        request(.GET, url, parameters: parameters)
//    }


    func sendStartSendCodeState() {
        var url = self.SENDCODE_BASE_URL + "/applicationstatlog.aspx"
        
        var parameters = Dictionary<String, AnyObject>()
        parameters["stat"] = "estcolapromo"
        parameters["param1"] = "ios"
        parameters["param2"] = "startsendcode"
        
        request(.GET, url, parameters: parameters)
    }

//    func sendGameStat(statname: String, label: String) {
//        var url:String
//        if statname == "estpromo" {
//            url = self.SENDCODE_BASE_URL + "/applicationstatlognoua.aspx"
//        } else {
//            url = self.GAME_BASE_URL + "/applicationstatlognoua.aspx"
//        }
//        
//        var parameters = Dictionary<String, AnyObject>()
//        parameters["stat"] = "\(statname)"
//        parameters["param1"] = "ios"
//        parameters["param2"] = "\(label)"
//        
//        request(.GET, url, parameters: parameters)
//    }
    
    func sendApplicationStatLog(parameters: [String : String]) {
        var url = self.SENDCODE_BASE_URL + "/applicationstatlognoua.aspx"
        request(.GET, url, parameters: parameters)
    }
    
    
    
    /*
    func getWinnerByMobileNumber(mobileno: String, cb: Callback<JSON>) -> Request {
        var parameters = Dictionary<String, AnyObject>()
        let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        var manager = Manager.sharedInstance
        
        parameters["mobileno"] = mobileno
        parameters["caller"] = "json"
        
        return manager.request(.POST, self.GET_WINNER_BY_MOBILE_NUMBER, parameters: parameters).responseJSON { (request, response, jsonData, error) in
            if let data: AnyObject = jsonData {
                var json = JSON(data)
                cb.callback(json, true, nil, nil)
            } else {
                cb.callback(nil, false, nil, error)
            }
        }
        
    }
    */
    
    
    
    func checkActiveApp(cb: Callback<JSON>) -> Request {
        var url = self.SENDCODE_BASE_URL + "/appactive.aspx"
        return request(.POST, url)
            .responseJSON { (_, _, jsonData, error) in
                    if let data: AnyObject = jsonData {
                        var json = JSON(data)
                        if (json["result"].string == "complete") {
                            
                            var detail = json["app"][0]
//                            println(detail["name"])
//                            println(detail)
                            println("appactive: \(detail)")
//                            var standardResponse = StandardResponse.getResponse(json)
                            cb.callback(json, true, nil, nil)
                        } else {
                            cb.callback(nil, false, json["result"].string, error)
                        }
                    } else {
                        cb.callback(nil, false, nil, error)
                    }
            }
    }
    
}