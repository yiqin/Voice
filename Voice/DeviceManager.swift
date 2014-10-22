//
//  DeviceManager.swift
//  Voice
//
//  Created by yiqin on 10/21/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import Foundation

class DeviceManager {
    
    var test:Int = 0{
        didSet{
            println("didSet called")
        }
        willSet(newValue){
            println("willSet called")
        }
    }
    
    var screenWidth : CGFloat = 0.0
    var screenHeight : CGFloat = 0.0
    
    
    
    class var sharedInstance : DeviceManager {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instance : DeviceManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = DeviceManager()
        }
        return Static.instance!
    }
    
}