//
//  DeviceManager.swift
//  Voice
//
//  Created by yiqin on 10/21/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import Foundation

/**
 Manages the size information, the location information
*/
class DeviceManager: NSObject {
    
    var screenWidth : CGFloat = 0.0
    var screenHeight : CGFloat = 0.0

    
    var adsLocations : NSMutableArray = []

    var cityName = "all"
    // If cityName is all, then load ads randomly
    // If cityName is specified, then load the ads
    
    /**
     Handle the size of screen.
    */
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
    
    /**
     Handle the location of ads. After getting the location, we need to use AdsLocation to fetch related ads.
     - Currently load Lafayette with the objectId TX1TdJitsX
    */
    func startLoadingRelatedAdsFromParse() {
        var query  = PFQuery(className: "AdsLocation")
        query.orderByDescending("updatedAt")
        
        query.getObjectInBackgroundWithId("TX1TdJitsX") { (object: PFObject!, error: NSError!) -> Void in
            self.adsLocations.addObject(AdsLocation(adsLocationPFObject: object))
            
            // A block is here
            
            AdsManager.sharedInstance.startLoadingDataFromParse(self.adsLocations.objectAtIndex(0) as AdsLocation)
        }
    }
    
    
    
    class var sharedInstance : DeviceManager {
        struct Static {
            static let instance = DeviceManager()
        }
        return Static.instance
    }
    
}