//
//  VoiceImage.swift
//  Voice
//
//  Created by yiqin on 10/23/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class VoiceImage: NSObject {
    
    var objectId: String
    var createdAt: NSDate
    var updatedAt: NSDate
    
    var image : PFImageView
    
    var parseObject: PFObject
    
    
    init(parseObject:PFObject) {
        objectId = parseObject.objectId
        createdAt = parseObject.createdAt
        updatedAt = parseObject.updatedAt
        
        // PFFile *thumbnail = [self.recipePFObject objectForKey:@"picture"];
        /*
        // PFFile *thumbnail = [self.recipePFObject objectForKey:@"picture"];
        self.image = [[PFImageView alloc] init];
        self.image.file = thumbnail;
        // self.image.image = thumbnailImageView.image.squareCroppedImage;
        [self.image loadInBackground:^(UIImage *image, NSError *error) {
        if (!error) {
        }
        }];
        */
        
        image = PFImageView()
        
        let thunmbnail = parseObject["image"] as PFFile
        image.file = thunmbnail
        image.loadInBackground { (image:UIImage!, error: NSError!) -> Void in
            println("Load voice image succesfully.")
        }
        
        // image = voiceImagePFObject["image"] as PFImageView
        self.parseObject = parseObject
    }
}
