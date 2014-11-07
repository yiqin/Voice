//
//  ArticleBlock.swift
//  Voice
//
//  Created by yiqin on 11/3/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class ArticleBlock:NSVoiceObject{
    
    var text:String
    var isText:Bool
    
    var image : VMImageView
    
    override init(parseObject:PFObject) {
        image = VMImageView()
        text = ""
        isText = parseObject["isText"] as Bool
        
        super.init(parseObject:parseObject)
        
        if (isText) {
            text = parseObject["text"] as String
        }
        else {
            let thunmbnail = parseObject["image"] as PFFile
            image.file = thunmbnail
            image.isLoading = true
            image.loadInBackground { (image:UIImage!, error: NSError!) -> Void in
                println("Load voice image succesfully.")
                self.image.isLoading = false
            }
        }
    };
}
