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
    
    var count : Int
    /// to check whether the images and the articles are laoding from Parse
    var isLoading : Bool = false
    
    var streetImage : StreetImage
    
    var articles : NSMutableArray = []
    
    override init(parseObject:PFObject) {
        let tempNumber = parseObject["number"] as NSNumber
        
        // Check this value later.
        number = 1
        
        count = 1
        streetImage = StreetImage()
        
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
                    self.streetImage = StreetImage(parseObject: object)
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
                self.count = self.count+objects.count
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
