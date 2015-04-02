//
//  Section.swift
//  Voice
//
//  Created by Yi Qin on 1/12/15.
//  Copyright (c) 2015 yiqin. All rights reserved.
//

import UIKit

class Session: NSVoiceObject {
    
    var image:UIImage?
    
    var title : String
    
    var number : Int

    
    var count : Int
    /// to check whether the images and the articles are laoding from Parse
    var isLoading : Bool = true
    
    var streetImage : StreetImage
    
    var articles:[Article]
    
    override init(parseObject:PFObject) {
        let tempNumber = parseObject["number"] as NSNumber
        
        println()
        println("session.......")
        println()
        
        title = parseObject["title"] as String
        
        
        // Check this value later.
        number = 1
        
        count = 1
        
        // streetImage = StreetImage(parseObject: parseObject["coverImage"] as PFObject)
        streetImage = StreetImage()
        
        articles = []
        
        
        super.init(parseObject:parseObject)
        
        startToLoadArticles()
        // startToLoadCoverImage()
        
        if let tempPFFile = parseObject["image"] as? PFFile {
            var tempPFImageView = PFImageView()
            tempPFImageView.file = tempPFFile
            
            tempPFImageView.loadInBackground { (image:UIImage!, error:NSError!) -> Void in
                self.isLoading = false
                self.image = image
            }
        }
        
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
                    self.isLoading = false
                }
                
                // self.startToLoadArticles()
                
            } else {
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }
    
    
    func startToLoadArticles(){
        var query = PFQuery(className: "Article")
        query.whereKey("belongTo", equalTo: self.parseObject)
        query.orderByAscending("createdAt")
        
        println("starting articlessssssssss")
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                println("successullly get Articles")
                
                // Only call this notification one time...
                // NSNotificationCenter.defaultCenter().postNotificationName("reloadSessionStreetImageTableViewCell", object: nil, userInfo: nil)
                
                
                self.startToLoadCoverImage()
                
                self.count = self.count+objects.count
                for object in objects {
                    let article = Article(parseObject: object as PFObject)
                    self.articles += [article]
                }

            } else {
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }

}
