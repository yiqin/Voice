//
//  Section.swift
//  Voice
//
//  Created by Yi Qin on 1/12/15.
//  Copyright (c) 2015 yiqin. All rights reserved.
//

import UIKit

class Session: NSVoiceObject {
    
    var number : Int
    
    /// to check whether the images and the articles are laoding from Parse
    var isLoading : Bool = false
    
    var coverImage : StreetImage
    
    var articles : NSMutableArray = []
    
    override init(parseObject:PFObject) {
        let tempNumber = parseObject["number"] as NSNumber
        number = 1
        coverImage = StreetImage()
        
        super.init(parseObject:parseObject)
        
        startToLoadCoverImage()
        startToLoadArticles()
    }
    
    func startToLoadCoverImage(){
        var query  = PFQuery(className: "StreetImage")
        query.whereKey("belongTo", equalTo: self.parseObject)

        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                println("successullly get StreetImage")
                if objects.count >= 1 {
                    let object = objects[0] as PFObject
                    self.coverImage = StreetImage(parseObject: object)
                }
            } else {
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }

    }
    
    func startToLoadArticles(){
        var query = PFQuery(className: "Article")
        query.whereKey("belongTo", equalTo: self.parseObject)
        
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                println("successullly get Articles")
                for object in objects {
                    let article = Article(parseObject: object as PFObject)
                    self.articles.addObject(article)
                }
            } else {
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }

}
