//
//  VoiceImage.swift
//  Voice
//
//  Created by yiqin on 10/23/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class StreetImage: NSVoiceObject {
    
    var who : String
    var photoBy : String
    
    var isFirstLoad : Bool
    var imagePFFile : PFFile?
    
    var image : PFImageView
    
    var uiimage : UIImage
    
    override init(parseObject:PFObject) {
        
        who = parseObject["who"] as String
        let tempString = parseObject["photoBy"] as String
        photoBy = "Photo By \(tempString)"
        
        image = PFImageView()
        uiimage = UIImage()
        
        imagePFFile = parseObject["image"] as? PFFile
        image.file = imagePFFile
        
        isFirstLoad = true
        
        super.init(parseObject:parseObject)
        
        /*
        image.loadInBackground { (image_:UIImage!, error: NSError!) -> Void in
            println("Load voice image succesfully.")
            self.isFirstLoad =  false
            self.uiimage = image_
            
        }
        */
    }
    
    override init() {
        who = ""
        photoBy = ""
        
        image = PFImageView()
        imagePFFile = PFFile()
        uiimage = UIImage()
        isFirstLoad = true
        
        super.init()
    }
    
    
}
