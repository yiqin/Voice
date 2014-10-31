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
    var updatedAt: NSDate
    
    var parseObject: PFObject
    
    var cityName: String
    var stateName: String
    
    init(parseObject:PFObject) {
        objectId = parseObject.objectId
        createdAt = parseObject.createdAt
        updatedAt = parseObject.updatedAt
        
        self.parseObject = parseObject
        
        cityName = parseObject["cityName"] as String
        stateName = parseObject["stateName"] as String
    };
}
