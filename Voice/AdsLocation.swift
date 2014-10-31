//
//  AdsLocation.swift
//  Voice
//
//  Created by yiqin on 10/27/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class AdsLocation: NSObject {
    
    var objectId: String
    var createdAt: NSDate
    var updateAt: NSDate
    
    var parseObject: PFObject
    
    var cityName: String
    var stateName: String
    
    init(adsLocationPFObject:PFObject) {
        objectId = adsLocationPFObject.objectId
        createdAt = adsLocationPFObject.createdAt
        updateAt = adsLocationPFObject.updatedAt
        
        parseObject = adsLocationPFObject
        
        cityName = adsLocationPFObject["cityName"] as String
        stateName = adsLocationPFObject["stateName"] as String
    };
}
