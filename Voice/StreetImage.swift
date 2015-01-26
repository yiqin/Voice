//
//  VoiceImage.swift
//  Voice
//
//  Created by yiqin on 10/23/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class StreetImage: NSVoiceObject {
    
    var isFirstLoad : Bool
    var imagePFFile : PFFile
    
    var image : PFImageView
    
    var uiimage : UIImage
    
    override init(parseObject:PFObject) {
        image = PFImageView()
        uiimage = UIImage()
        
        imagePFFile = parseObject["image"] as PFFile
        image.file = imagePFFile
        
        isFirstLoad = true
        
        super.init(parseObject:parseObject)
        
        image.loadInBackground { (image_:UIImage!, error: NSError!) -> Void in
            println("Load voice image succesfully.")
            self.isFirstLoad =  false
            self.uiimage = image_
            
            NSNotificationCenter.defaultCenter().postNotificationName("reloadSessionStreetImageTableViewCell", object: nil, userInfo: nil)
        }
    }
    
    override init() {
        image = PFImageView()
        imagePFFile = PFFile()
        uiimage = UIImage()
        isFirstLoad = true
        
        super.init()
    }
    
    
}
