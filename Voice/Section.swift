//
//  Section.swift
//  Voice
//
//  Created by Yi Qin on 1/12/15.
//  Copyright (c) 2015 yiqin. All rights reserved.
//

import UIKit

class Section: NSVoiceObject {
    
    var number : Int
    
    /// to check whether the images and the articles are laoding from Parse
    var isLoading : Bool = false
    
    var coverImage : StreetImage
    
    
    override init(parseObject:PFObject) {
        number = parseObject["number"] as Int
        coverImage = StreetImage()
        
        super.init(parseObject:parseObject)
        
        startToLoadCoverImage()
    }
    
    func startToLoadCoverImage(){
       var query  = PFQuery(className: "StreetImage")
        query.whereKey("belongTo", equalTo: self.parseObject)
        
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                println("successullly")
                if objects.count >= 1 {
                    let object = objects[0] as PFObject
                    self.coverImage = StreetImage(parseObject: object)
                }
            } else {
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }

    }

}
