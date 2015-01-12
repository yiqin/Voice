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
    
    /// Parse.com maybe retrun several AdsLocation. But we just use the first one.
    var adsLocations : NSMutableArray = []

    /// If cityName is all, then load ads randomly. If cityName is specified, then load the ads
    var cityName = "all"

    
    class var sharedInstance : DeviceManager {
        struct Static {
            static let instance = DeviceManager()
        }
        return Static.instance
    }
    
    
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
    
    // No use anymore
    /**
     Handle the location of ads. After getting the location, we need to use AdsLocation to fetch related ads.
     - Currently load Lafayette with the objectId "TX1TdJitsX", it should be cityName in the next version.
    */
    /*
    func startLoadingRelatedAdsFromParse() {
        var query  = PFQuery(className: "AdsLocation")
        query.orderByDescending("updatedAt")
        
        query.getObjectInBackgroundWithId("TX1TdJitsX") { (object: PFObject!, error: NSError!) -> Void in
            
            self.adsLocations.addObject(AdsLocation(parseObject: object))
            AdsManager.sharedInstance.startLoadingDataFromParse(self.adsLocations.objectAtIndex(0) as AdsLocation)
        }
    }
    */

}