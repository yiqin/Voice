//
//  VoiceImagesManager.swift
//  Voice
//
//  Created by yiqin on 10/23/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class VoiceImagesManager: NSObject {
    
    let numberPerRow = 5;
    var numberOfRows = 0;
    var voiceImages : NSMutableArray = [];

    class var sharedInstance : VoiceImagesManager {
        struct Static {
            static let instance = VoiceImagesManager()
        }
        return Static.instance
    }
    
    func startLoadingDataFromParse() {
        var query  = PFQuery(className: "VoiceImage")
        query.orderByAscending("updatedAt")
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                println("Load voice images from Parse.com.")
                if objects.count%self.numberPerRow == 0 {
                    self.numberOfRows = objects.count/self.numberPerRow      // Start from 1
                }
                else {
                    self.numberOfRows = objects.count/self.numberPerRow+1     // Start from 1
                }
                
                
                println("The total number of rows is \(self.numberOfRows)")
                
                var recievedVoiceImages = NSMutableArray()
                
                for object in objects {
                    let newVoiceImage = VoiceImage(voiceImagePFObject: object as PFObject)
                    recievedVoiceImages.addObject(newVoiceImage)
                }
                
                self.voiceImages.removeAllObjects()
                self.voiceImages.addObjectsFromArray(recievedVoiceImages)
                
                self.fetchVoiceImagesWithRowIndex(1)    // check 2nd row -> 1
            } else {
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }
    
    func addVoiceImage(newVoiceImage:VoiceImage) {
        voiceImages.addObject(newVoiceImage)
    }
    
    func fetchVoiceImagesWithRowIndex(rowIndex:Int) -> NSArray
    {
        if rowIndex > (numberOfRows-1) {        // Start from 1
            return []
        }
        else {
            let startIndex = rowIndex*numberPerRow
            var arrayLength = 0
            if ((rowIndex+1)*numberPerRow > voiceImages.count) {
                arrayLength = voiceImages.count%numberPerRow
            }
            else {
                arrayLength = numberPerRow
            }
            
            println("How many images in the last row: \(arrayLength)")
            println(voiceImages.subarrayWithRange(NSMakeRange(startIndex, arrayLength)).count)
            
            return voiceImages.subarrayWithRange(NSMakeRange(startIndex, arrayLength))
        }
    }
    
}
