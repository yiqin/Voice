//
//  VoiceImagesManager.swift
//  Voice
//
//  Created by yiqin on 10/23/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

/**
 Manages images that shown on the main view controller.
*/
class StreetImagesManager: NSObject {
    
    /// The numbers of images in a row.
    var numberPerRow = 5
    /// The numbers of rows in the image table view.
    var numberOfRows = 0
    var streetImages : NSMutableArray = []
    
    /// Collection content offsets for every row.
    var collectionContentOffsets = NSMutableDictionary();
    
    class var sharedInstance : StreetImagesManager {
        struct Static {
            static let instance = StreetImagesManager()
        }
        return Static.instance
    }
    
    /**
     return too much image would carse problem.
     */
    func startLoadingDataFromParse() {
        var query  = PFQuery(className: "StreetImage")
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
                
                var recievedImages = NSMutableArray()
                
                
                for object in objects {
                    let newImage = StreetImage(parseObject: object as PFObject)
                    recievedImages.addObject(newImage)
                }
                
                self.streetImages.removeAllObjects()
                self.streetImages.addObjectsFromArray(recievedImages)
                
                // self.fetchStreetImagesWithRowIndex(1)    // check 2nd row -> 1
                
                // Then we start to load config paramters.
                ConfigDataManager.sharedInstance.startToRetrieveConfig()
            } else {
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }
    
    func addStreetImage(newStreetImage:StreetImage) {
        streetImages.addObject(newStreetImage)
    }
    
    /**
     Fecth voice images.
    
     :param: rowIndex row index in the table view on DownViewn
     :return: NSArray that contains voiceImages
    */
    func fetchStreetImagesWithRowIndex(rowIndex:Int) -> NSArray {
        if rowIndex > (numberOfRows-1) {        // Start from 1
            return []
        }
        else {
            let startIndex = rowIndex*numberPerRow
            var arrayLength = 0
            if ((rowIndex+1)*numberPerRow > streetImages.count) {
                arrayLength = streetImages.count%numberPerRow
            }
            else {
                arrayLength = numberPerRow
            }
            
            // println("How many images in the last row: \(arrayLength)")
            // println(streetImages.subarrayWithRange(NSMakeRange(startIndex, arrayLength)).count)
            
            return streetImages.subarrayWithRange(NSMakeRange(startIndex, arrayLength))
        }
    }
    
    /**
    Collection content offset
    
    :rowIndex: rowIndex row index in the table view on DownView
    :return: return collection content offset
    */
    func getCollectionContentOffset(rowIndex:Int) -> CGFloat {
        
        if ((collectionContentOffsets.objectForKey(rowIndex)) != nil){
            return collectionContentOffsets.objectForKey(rowIndex) as CGFloat
        }
        else {
            return CGFloat(0)
        }
    }
    
    /**
    Collection content offset
    
    :rowIndex: rowIndex row index in the table view on DownViewn
    :offset: the updated offset in the specified row.
    */
    func setCollectionContentOffset(rowIndex:Int, offset:CGFloat) {
        collectionContentOffsets.setObject(offset, forKey: rowIndex)
    }
}
