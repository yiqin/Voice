//
//  Ad.swift
//  Voice
//
//  Created by yiqin on 10/25/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class Ad: NSObject {
    
    var objectId: String
    var createdAt: NSDate
    var updatedAt: NSDate
    
    var parseObject: PFObject
    
    var name: String
    var atLocationName: String
    
    /// multiply ad images belonged to each ad.
    var adImages : NSMutableArray = []
    
    init(articlePFObject:PFObject) {
        objectId = articlePFObject.objectId
        createdAt = articlePFObject.createdAt
        updatedAt = articlePFObject.updatedAt
        
        parseObject = articlePFObject
        
        name = articlePFObject["name"] as String
        atLocationName = articlePFObject["atLocationName"] as String
    }
    
    
    func loadAdImagesFromParse() {
        var query  = PFQuery(className: "AdImage")
        query.orderByDescending("updatedAt")
        query.whereKey("belongTo", equalTo: self.parseObject)
        
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in

            if error == nil {
                var recievedAdImages = NSMutableArray()
                
                for object in objects {
                    let newAdImage = AdImage(adImagePFObject: object as PFObject)
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
