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
    var updateAt: NSDate
    
    var parseObject: PFObject
    
    var cityName: String
    
    
    init(articlePFObject:PFObject) {
        objectId = articlePFObject.objectId
        createdAt = articlePFObject.createdAt
        updateAt = articlePFObject.updatedAt
        
        parseObject = articlePFObject
        
        cityName = articlePFObject["cityName"] as String
    };
    
   
}
