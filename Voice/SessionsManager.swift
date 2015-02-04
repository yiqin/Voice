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
class SessionsManager: NSObject {
    
    /// Update this variable
    var sessions : NSMutableArray = []
    var currentPageIndex = 0;
    let itemsPerPage = kNumberOfSectionPerQuery;
    
    class var sharedInstance : SessionsManager {
        struct Static {
            static let instance = SessionsManager()
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
        var query  = PFQuery(className: "Session")
        query.whereKey("isPublished", equalTo: true)
        query.orderByDescending("number")
        query.limit = itemsPerPage
        query.skip = pageIndex*itemsPerPage
        
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                println("Load sessions - #\(objects.count) from Parse.com.")
                var recieved = NSMutableArray()
                
                for object in objects {
                    let newSection = Session(parseObject: object as PFObject)
                    recieved.addObject(newSection)
                }
                
                if (pageIndex == 0){
                    self.sessions.removeAllObjects()
                }
                self.sessions.addObjectsFromArray(recieved)
                completionClosure(success: true)
                
                if(pageIndex >= 10 || (objects.count == 0) ){
                    
                }
                else {
                    NSTimer.scheduledTimerWithTimeInterval(1.00, target: self, selector: Selector("continueLoading"), userInfo: nil, repeats: false)
                }
                
            } else {
                NSLog("Error: %@ %@", error, error.userInfo!)
                completionClosure(success: false)
            }
        }
    }
    
    func continueLoading(){
        loadMoreDataFromParse { (success) -> () in
            
        }
        
    }
    
    /// for propagation
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
