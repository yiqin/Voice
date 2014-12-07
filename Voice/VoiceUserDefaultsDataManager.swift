//
//  NSUserDefaultsDataManager.swift
//  Voice
//
//  Created by Yi Qin on 12/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class VoiceUserDefaultsDataManager: NSObject {
    
    // var firstTimeLoadWithoutAnyUserDefaults = false;
    
    class var sharedInstance : VoiceUserDefaultsDataManager {
        struct Static {
            static let instance = VoiceUserDefaultsDataManager()
        }
        return Static.instance
    }
    
    func checkFirstTimeLoad() -> Bool{
        var returnValue: Bool? = NSUserDefaults.standardUserDefaults().objectForKey("VoiceFirstTimeLoad") as? Bool
        if returnValue == nil //Check for first run of app
        {
            returnValue = false //Default value
            NSUserDefaults.standardUserDefaults().setObject(true, forKey: "VoiceFirstTimeLoad")
        }
        
        
        return returnValue!
        
        
    }
    
    func setLaunchingGIF(launchingGIF : PFFile){
        launchingGIF.getDataInBackgroundWithBlock { (data:NSData!, error:NSError!) -> Void in
            NSUserDefaults.standardUserDefaults().setObject(data, forKey: "VoiceLaunchingGIF")
        }
    }
    
    func getLaunchingGIF() -> NSData {
        var data = NSUserDefaults.standardUserDefaults().objectForKey("VoiceLaunchingGIF") as NSData
        
        return data
    }
    
    
}
