//
//  News.swift
//  Voice
//
//  Created by yiqin on 10/22/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class Article: NSVoiceObject {
    
    var title: String
    var briefDescription: String
    var briefImage : PFImageView
    
    init(parseObject:PFObject) {
        super.init(parseObject:parseObject)
        
        title = parseObject["title"] as String
        briefDescription = parseObject["briefDescription"] as String    // How to check this value
        
        briefImage = PFImageView()
        
        let thunmbnail = parseObject["briefImage"] as PFFile
        briefImage.file = thunmbnail
        briefImage.loadInBackground { (image:UIImage!, error: NSError!) -> Void in
            println("Load article image succesfully.")
        }
        
    };
    
}
