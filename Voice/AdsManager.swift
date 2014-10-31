//
//  AdManager.swift
//  Voice
//
//  Created by yiqin on 10/25/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

/**
 Manages all user information. It includes
*/
class AdsManager: NSObject {
    
    var ads : NSMutableArray = []
    
    class var sharedInstance : AdsManager {
        struct Static {
            static let instance = AdsManager()
        }
        return Static.instance
    }
    
    /**
     Load ads from Parse.com acoording to the location, and save them into AdManager.sharedInstance.ads
    
     :param: location the location information wrapped in AdsLocation
    */
    func startLoadingDataFromParse(location: AdsLocation) {
        var query  = PFQuery(className: "Ad")
        query.whereKey("atLocation", equalTo: location.parseObject)
        
        query.orderByAscending("updatedAt")
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                println("Load ads from Parse.com.")
                var recievedAds = NSMutableArray()
                
                for object in objects {
                    let newAd = Ad(articlePFObject: object as PFObject)
                    newAd.loadAdImagesFromParse()
                    
                    println(newAd.name)     // check the result
                    
                    recievedAds.addObject(newAd)
                }
                
                self.ads.removeAllObjects()
                self.ads.addObjectsFromArray(recievedAds)
                
            } else {
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
        
    }
   
}
