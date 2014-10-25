//
//  AdManager.swift
//  Voice
//
//  Created by yiqin on 10/25/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class AdManager: NSObject {
    
    var ads : NSMutableArray = []
    
    class var sharedInstance : AdManager {
        struct Static {
            static let instance = AdManager()
        }
        return Static.instance
    }
    
    func startLoadingDataFromParse() {
        var query  = PFQuery(className: "Ad")
        
        /************************************/
        // where operation is here
        
        query.orderByAscending("updatedAt")
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                println("Load ads from Parse.com.")
                var recievedAds = NSMutableArray()
                
                for object in objects {
                    let newAd = Ad(articlePFObject: object as PFObject)
                    println(newAd.cityName)
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
