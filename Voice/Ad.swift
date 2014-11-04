//
//  Ad.swift
//  Voice
//
//  Created by yiqin on 10/25/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class Ad: NSVoiceObject {
    
    var name: String
    var atLocationName: String
    
    /// multiply ad images belonged to each ad.
    var adImages : NSMutableArray = []
    
    override init(parseObject:PFObject) {
        name = parseObject["name"] as String
        atLocationName = parseObject["atLocationName"] as String
        
        super.init(parseObject:parseObject)
    }
    
    func loadAdImagesFromParse() {
        var query  = PFQuery(className: "AdImage")
        query.orderByDescending("updatedAt")
        query.whereKey("belongTo", equalTo: self.parseObject)
        
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in

            if error == nil {
                var recievedAdImages = NSMutableArray()
                
                for object in objects {
                    let newAdImage = AdImage(parseObject: object as PFObject)
                    recievedAdImages.addObject(newAdImage)
                }
                
                self.adImages.removeAllObjects()
                self.adImages.addObjectsFromArray(recievedAdImages)
                
            } else {
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }

}
