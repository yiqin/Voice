//
//  AdImage.swift
//  Voice
//
//  Created by yiqin on 10/31/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class AdImage: NSObject {
    
    var objectId: String
    var createdAt: NSDate
    var updatedAt: NSDate
    
    var image : PFImageView
    
    var parseObject: PFObject
    
    
    init(parseObject:PFObject) {
        objectId = parseObject.objectId
        createdAt = parseObject.createdAt
        updatedAt = parseObject.updatedAt
        
        image = PFImageView()
        
        let thunmbnail = parseObject["image"] as PFFile
        image.file = thunmbnail
        image.loadInBackground { (image:UIImage!, error: NSError!) -> Void in
            println("Load ad image succesfully.")
        }
        
        self.parseObject = parseObject
    }
   
}
