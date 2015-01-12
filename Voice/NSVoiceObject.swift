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
    
    /// unique id on Parse
    var objectId: String
    /// created time on Parse
    var createdAt: NSDate
    /// latest updated time on Parse
    var updatedAt: NSDate
    /// the whole PFObject on Parse
    var parseObject: PFObject
    
    init(parseObject:PFObject) {
        objectId = parseObject.objectId
        createdAt = parseObject.createdAt
        updatedAt = parseObject.updatedAt
        self.parseObject = parseObject
        super.init()
    }
    
    override init() {
        objectId = ""
        createdAt = NSDate()
        updatedAt = NSDate()
        parseObject = PFObject(className: "hello") // Spent half hours to fix this bug.
        super.init()
    }
}
