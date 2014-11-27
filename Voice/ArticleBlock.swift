//
//  ArticleBlock.swift
//  Voice
//
//  Created by yiqin on 11/3/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class ArticleBlock:NSVoiceObject{
    
    var htmlData : NSData
    
    /**
    check whether the html is downloading. Default value is false.
    - true: downloading.
    - false: not downloading.
    */
    var isHtmlLoading = false
    
    override init(parseObject:PFObject) {
        
        let htmlPFFile = parseObject["html"] as PFFile
        
        htmlData = NSData()

        super.init(parseObject:parseObject)
        
        htmlPFFile.getDataInBackgroundWithBlock({ (receivedHtmlData: NSData!, error: NSError!) -> Void in
            
            println("Load HTML successfully.")
            
            self.isHtmlLoading = true
            self.htmlData = receivedHtmlData
        })
        
    };
}
