//
//  KeychainUtility.swift
//  EST
//
//  Created by meow kling :3 on 9/18/2558 BE.
//  Copyright (c) 2558 Adapter Digital Co., Ltd. All rights reserved.
//

import Foundation
import UIKit
import Security

class KeychainUtility: NSObject {
   
    class var keychainUtilityInstance: KeychainUtility {
    struct Static {
        static let instance: KeychainUtility = KeychainUtility()
        }
        return Static.instance
    }
    
    func setObject(key: String, value: String) {
        var dataFromString: NSData = value.dataUsingEncoding(NSUTF8StringEncoding)!;
        var keychainQuery = [
            kSecClass as NSString : kSecClassGenericPassword,
            kSecAttrService : key,
            kSecValueData as NSString : dataFromString];
        SecItemDelete(keychainQuery as CFDictionaryRef);
        var status: OSStatus = SecItemAdd(keychainQuery as CFDictionaryRef, nil);
    }
    
    func getObject(key: String) -> String {
        var keychainQuery = NSMutableDictionary(objects: [kSecClassGenericPassword, key, kCFBooleanTrue, kSecMatchLimitOne], forKeys: [kSecClass, kSecAttrService, kSecReturnData, kSecMatchLimit])
        var passcode: String = ""
        
        var result: AnyObject?
        var status = withUnsafeMutablePointer(&result) { SecItemCopyMatching(keychainQuery, UnsafeMutablePointer($0)) }
        
        if let data = result as! NSData? {
            if let string = NSString(data: data, encoding: NSUTF8StringEncoding) {
                passcode = string as String
            }
        }
        return passcode;
    }
    
    func deleteObject(key: String) {
        var keychainQuery = NSMutableDictionary(objects: [kSecClassGenericPassword, key, kCFBooleanTrue, kSecMatchLimitOne], forKeys: [kSecClass, kSecAttrService, kSecReturnData, kSecMatchLimit])
        var status: OSStatus = SecItemDelete(keychainQuery as CFDictionaryRef)
    }
    
}