//
//  NSUserDefaultsDataManager.swift
//  Voice
//
//  Created by Yi Qin on 12/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class NSUserDefaultsDataManager: NSObject {
    
    class var sharedInstance : NSUserDefaultsDataManager {
        struct Static {
            static let instance = NSUserDefaultsDataManager()
        }
        return Static.instance
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
