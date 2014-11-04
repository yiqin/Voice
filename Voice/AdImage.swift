//
//  AdImage.swift
//  Voice
//
//  Created by yiqin on 10/31/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class AdImage: NSVoiceObject {
    
    var image : PFImageView
    
    override init(parseObject:PFObject) {
        image = PFImageView()
        
        let thunmbnail = parseObject["image"] as PFFile
        image.file = thunmbnail
        image.loadInBackground { (image:UIImage!, error: NSError!) -> Void in
            println("Load ad image succesfully.")
        }
        
        super.init(parseObject:parseObject)
    }
   
}
