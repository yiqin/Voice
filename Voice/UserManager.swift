//
//  UserManager.swift
//  Voice
//
//  Created by yiqin on 10/27/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import Foundation

class UserManager: NSObject {
    
    var adsLocations : NSMutableArray = []
    
    class var sharedInstance : UserManager {
        struct Static {
            static let instance = UserManager()
        }
        return Static.instance
    }
    
    func startLoadingRelatedAdsFromParse() {
        var query  = PFQuery(className: "AdsLocation")
        query.orderByDescending("updatedAt")
        
        query.getObjectInBackgroundWithId("TX1TdJitsX") { (object: PFObject!, error: NSError!) -> Void in
            self.adsLocations.addObject(AdsLocation(adsLocationPFObject: object))
            
            // A block is here
            AdManager.sharedInstance
            AdManager.sharedInstance.startLoadingDataFromParse(self.adsLocations.objectAtIndex(0) as AdsLocation)
        }
    }
    
    
}
