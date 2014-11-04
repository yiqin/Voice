//
//  NSVoiceObject.swift
//  Voice
//
//  Created by yiqin on 11/3/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

/**
 General super class in the Voice
*/
class NSVoiceObject: NSObject {
    
    var objectId: String
    var createdAt: NSDate
    var updatedAt: NSDate
    var parseObject: PFObject
    
    init(parseObject:PFObject) {
        objectId = parseObject.objectId
        createdAt = parseObject.createdAt
        updatedAt = parseObject.updatedAt
        self.parseObject = parseObject
    }
}
