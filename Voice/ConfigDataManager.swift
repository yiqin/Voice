//
//  ConfigDataManager.swift
//  Voice
//
//  Created by yiqin on 11/23/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

/**
 Configuration data from Parse.com
*/
class ConfigDataManager: NSObject {
    
    class func startToRetrieveConfig(){
        NSLog("Getting the latest config...");
        PFConfig.getConfigInBackgroundWithBlock {
            (var config: PFConfig!, error: NSError!) -> Void in
            if ((error) != nil) {
                NSLog("Yay! Config was fetched from the server.")
            } else {
                NSLog("Failed to fetch. Using Cached Config.")
                // config = PFConfig.currentConfig()
            }
            
            /// launching gif is saved locally. It can ba updated every time the app launches. The latest one will display.
            var launchingGIF = config["launchingGIF"] as? PFFile
            if launchingGIF == nil {
                println("Falling back to default message.")
                
            }
            else {
                println("Success....")
                VoiceUserDefaultsDataManager.sharedInstance.setLaunchingGIF(launchingGIF!)
                
            }
        }
    }
}
