//
//  News.swift
//  Voice
//
//  Created by yiqin on 10/22/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class Article: NSObject {
    
    var objectId: String
    var createdAt: NSDate
    var updateAt: NSDate
    
    var title: String
    var briefDescription: String
    var briefImage : PFImageView
    
    var parseObject: PFObject
    
    init(articlePFObject:PFObject) {
        objectId = articlePFObject.objectId
        createdAt = articlePFObject.createdAt
        updateAt = articlePFObject.updatedAt
        
        title = articlePFObject["title"] as String
        briefDescription = articlePFObject["briefDescription"] as String    // How to check this value
        
        
        briefImage = PFImageView()
        
        let thunmbnail = articlePFObject["briefImage"] as PFFile
        briefImage.file = thunmbnail
        briefImage.loadInBackground { (image:UIImage!, error: NSError!) -> Void in
            println("Load article image succesfully.")
        }
        
        parseObject = articlePFObject
    };
    
}
