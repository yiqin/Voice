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
    var briefImage: PFImageView
    var coverImage: PFImageView
    
    var articleBlocks : NSMutableArray = []
    
    override init(parseObject:PFObject) {
        title = parseObject["title"] as String
        briefDescription = parseObject["briefDescription"] as String    // How to check this value
        
        briefImage = PFImageView()
        let thunmbnail = parseObject["briefImage"] as PFFile
        briefImage.file = thunmbnail
        briefImage.loadInBackground { (image:UIImage!, error: NSError!) -> Void in
            println("Load article image succesfully.")
        }
        
        coverImage = PFImageView()
        let thunmbnail2 = parseObject["coverImage"] as PFFile
        coverImage.file = thunmbnail2
        coverImage.loadInBackground { (image:UIImage!, error: NSError!) -> Void in
            println("Load cover image succesfully.")
        }
        
        super.init(parseObject:parseObject)
    };
    
    func startLoading(){
        // remove articleblocks no mater what it has.
        ArticleDetailManager.sharedInstance.removeArticleBlocks()
        
        // If articleBlocks already have contents, directly return. No need to load again.
        if (articleBlocks.count>0){
            ArticleDetailManager.sharedInstance.addAllArticleBlcoks(articleBlocks)
            return
        }

        var query  = PFQuery(className: "ArticleBlock")
        query.orderByAscending("indexNumber")
        query.whereKey("belongTo", equalTo: self.parseObject)
        
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                var recievedObjects = NSMutableArray()
                
                /*****************************/
                // This is not a safe method.
                // Only one object is returned.
                for object in objects {
                    let newReadyObject = ArticleBlock(parseObject: object as PFObject)
                    println(newReadyObject.text)
                    
                    // Add it to ArticleDetailManager
                    ArticleDetailManager.sharedInstance.addArticleBlock(newReadyObject)
                    
                    recievedObjects.addObject(newReadyObject)
                }
                
                // Send a notification to tableViewControlle to relaod the data.
                NSNotificationCenter.defaultCenter().postNotificationName("VoiceReload", object: nil)
                
                self.articleBlocks.removeAllObjects()
                self.articleBlocks.addObjectsFromArray(recievedObjects)
                
            } else {
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }

}
