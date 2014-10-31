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
    
    
    init(adImagePFObject:PFObject) {
        objectId = adImagePFObject.objectId
        createdAt = adImagePFObject.createdAt
        updatedAt = adImagePFObject.updatedAt
        
        image = PFImageView()
        
        let thunmbnail = adImagePFObject["image"] as PFFile
        image.file = thunmbnail
        image.loadInBackground { (image:UIImage!, error: NSError!) -> Void in
            println("Load ad image succesfully.")
        }
        
        parseObject = adImagePFObject
    }
   
}
