//
//  CloudCodeManager.swift
//  Voice
//
//  Created by Yi Qin on 12/13/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

/**
  Cloud Code Function Manager
*/
class CloudCodeManager: NSObject {
    
    class func sendTestHello() {
        let parameters = [:]
        PFCloud.callFunctionInBackground("hello", withParameters: parameters) { (result:AnyObject!, error:NSError!) -> Void in
            if (error == nil) {
                println("Hello world!")
            }
        }
    }
    
    /// quick send verification code
    class func sendVerificationCode(phoneNumber:NSNumber) {
        CloudCodeManager.sendVerificationCode(phoneNumber, completionClosure: { (success) -> () in
            
        })
    }
    
    /// send verification code with closure
    class func sendVerificationCode(phoneNumber:NSNumber, completionClosure: (success :Bool) ->()) {
        let parameters = ["phoneNumber":phoneNumber]
        PFCloud.callFunctionInBackground("sendVerificationCode", withParameters: parameters) { (result:AnyObject!, error:NSError!) -> Void in
            if(error == nil){
                completionClosure(success: true)
            }
            else {
                completionClosure(success: false)
            }
        }
    }
    
    /// quick verify phone number with phoneNumber and phone verification code
    class func verifyPhoneNumber(phoneNumber:NSNumber, phoneVerificationCode:NSNumber) {
        CloudCodeManager.verifyPhoneNumber(phoneNumber, phoneVerificationCode: phoneVerificationCode) { (success) -> () in
            
        }
    }
    
    /// verify phone number with phoneNumber and phone verification code with closure
    class func verifyPhoneNumber(phoneNumber:NSNumber, phoneVerificationCode:NSNumber, completionClosure: (success :Bool) ->()) {
        let parameters = ["phoneNumber":phoneNumber,
                          "phoneVerificationCode": phoneVerificationCode]
        PFCloud.callFunctionInBackground("verifyPhoneNumber", withParameters: parameters) { (result:AnyObject!, error:NSError!) -> Void in
            if(error == nil){
                completionClosure(success: true)
            }
            else {
                completionClosure(success: false)
            }
        }
    }
    
    
}
