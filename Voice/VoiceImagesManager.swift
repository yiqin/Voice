//
//  VoiceImagesManager.swift
//  Voice
//
//  Created by yiqin on 10/23/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class VoiceImagesManager: NSObject {
    
    var voiceImages : NSMutableArray = [];

    class var sharedInstance : VoiceImagesManager {
        struct Static {
            static let instance = VoiceImagesManager()
        }
        return Static.instance
    }
    
    func startLoadingDataFromParse() {
        var query  = PFQuery(className: "VoiceImage")
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                println("Load voice images from Parse.com.")
                var recievedVoiceImages = NSMutableArray()
                
                for object in objects {
                    let newVoiceImage = VoiceImage(voiceImagePFObject: object as PFObject)
                    recievedVoiceImages.addObject(newVoiceImage)
                }
                
                self.voiceImages.removeAllObjects()
                self.voiceImages.addObjectsFromArray(recievedVoiceImages)
            } else {
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }
    
    func addVoiceImage(newVoiceImage:VoiceImage) {
        voiceImages.addObject(newVoiceImage)
    }

}
