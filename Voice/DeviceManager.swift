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
    
    func setDeviceSize() {
        /****************************************/
        // Not saving locally yet.
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let width = userDefaults.floatForKey("screenSizeWidth") as Float?
        if (width != 0) {
            screenWidth = CGFloat(width!)
        } else {
            screenWidth = UIScreen.mainScreen().bounds.width;
        }
        
        let height = userDefaults.floatForKey("screenSizeHeight") as Float?
        if (height != 0) {
            screenHeight = CGFloat(height!)
        } else {
            screenHeight = UIScreen.mainScreen().bounds.height;
        }
        
    }
    
    class var sharedInstance : DeviceManager {
        struct Static {
            static let instance = DeviceManager()
        }
        return Static.instance
    }
    
}