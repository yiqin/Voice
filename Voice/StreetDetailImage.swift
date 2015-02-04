//
//  StreetDetailImage.swift
//  Voice
//
//  Created by Yi Qin on 2/4/15.
//  Copyright (c) 2015 yiqin. All rights reserved.
//

import UIKit

class StreetDetailImage: NSVoiceObject {
    
    var isImageLoading : Bool
    var imagePFFile : PFFile
    var image : UIImage
    var imageCellHeight : CGFloat
    
    override init(parseObject:PFObject) {
        
        isImageLoading = true
        imagePFFile = parseObject["image"] as PFFile
        image = UIImage()
        
        let ratio = parseObject["ratio"] as NSNumber
        let tempScreenBounds = UIScreen.mainScreen().bounds
        let tempScreenSize   = kScreenBounds.size
        let tempScreenWidth  = kScreenSize.width
        imageCellHeight = tempScreenWidth/CGFloat(ratio.floatValue)
        
        super.init(parseObject:parseObject)
        
        let imagePFImageView = PFImageView()
        imagePFImageView.file = imagePFFile
        imagePFImageView.loadInBackground { (image:UIImage!, error:NSError!) -> Void in
            self.image = image
            self.isImageLoading = false
        }
        
    }

}
