//
//  ArticleDetail.swift
//  Voice
//
//  Created by yiqin on 11/3/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class ArticleDetail: NSVoiceObject {
    
    var articleBlocks : NSMutableArray = []
    
    
        
    
    override init(parseObject:PFObject) {
        
        
        
        super.init(parseObject:parseObject)
        
        // Fetch Article Blockes.
        
        
        // Put this into DataManager
        var query  = PFQuery(className: "ArticleBlock")
        query.orderByDescending("updatedAt")
        query.whereKey("belongTo", equalTo: self.parseObject)
        
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                var recievedObjects = NSMutableArray()
                
                for object in objects {
                    let newReadyObject = ArticleBlock(parseObject: object as PFObject)
                    println(newReadyObject.text)
                    
                    // Add it to ArticleDetailManager
                    ArticleDetailManager.sharedInstance.addArticleBlock(newReadyObject)
                    
                    recievedObjects.addObject(newReadyObject)
                }
                
                // Send a notification to tableViewControlle to relaod the data.
                
                self.articleBlocks.removeAllObjects()
                self.articleBlocks.addObjectsFromArray(recievedObjects)
                
            } else {
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
        
        
    };
    

    
}
