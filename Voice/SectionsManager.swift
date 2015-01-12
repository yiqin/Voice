//
//  SectionsManager.swift
//  Voice
//
//  Created by Yi Qin on 1/12/15.
//  Copyright (c) 2015 yiqin. All rights reserved.
//

import UIKit

/**
 Load sections manager. Use this section as the key to load related street images and articles.
*/
class SectionsManager: NSObject {
    
    var sections : NSMutableArray = []
    var currentPageIndex = 0;
    let itemsPerPage = 10;
    
    class var sharedInstance : ArticlesManager {
        struct Static {
            static let instance = ArticlesManager()
        }
        return Static.instance
    }
    
    /**
    quick way to start to load article data from Parse.com
    */
    func startLoadingDataFromParse(pageIndex:Int) {
        startLoadingDataFromParse(pageIndex, completionClosure: { (success) -> () in
            
        })
    }
    
    /// with Closure............
    func startLoadingDataFromParse(pageIndex:Int, completionClosure: (success :Bool) ->()) {
        var query  = PFQuery(className: "Section")
        
        query.orderByDescending("number")
        query.limit = itemsPerPage
        query.skip = pageIndex*itemsPerPage
        
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                println("Load sections from Parse.com.")
                var recieved = NSMutableArray()
                
                for object in objects {
                    let newSection = Section(parseObject: object as PFObject)
                    recieved.addObject(newSection)
                }
                
                if (pageIndex == 0){
                    self.sections.removeAllObjects()
                }
                self.sections.addObjectsFromArray(recieved)
                completionClosure(success: true)
                
            } else {
                NSLog("Error: %@ %@", error, error.userInfo!)
                completionClosure(success: false)
            }
        }
    }
    
    func loadMoreDataFromParse(completionClosure: (success :Bool) ->()){
        currentPageIndex++;
        startLoadingDataFromParse(currentPageIndex, completionClosure: { (success) -> () in
            if (success){
                completionClosure(success: true)
            }
            else {
                completionClosure(success: false)
            }
        })
    }
    
    
    
}
