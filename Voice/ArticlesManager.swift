//
//  ArticlesManager.swift
//  Voice
//
//  Created by yiqin on 10/22/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

/**
 Manages the list of articles in the main view.
 Each item has Article class, rather than ArticleDetail class.
*/
class ArticlesManager: NSObject {
    
    var articles : NSMutableArray = []
    var currentPageIndex = 0;
    let itemsPerPage = 5;
    
    class var sharedInstance : ArticlesManager {
        struct Static {
            static let instance = ArticlesManager()
        }
        return Static.instance
    }
    
    func startLoadingDataFromParse(pageIndex:Int) {
        var query  = PFQuery(className: "Article")
        
        query.orderByDescending("createdAt")
        query.limit = itemsPerPage
        query.skip = pageIndex*itemsPerPage
        
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                println("Load articles from Parse.com.")
                var recievedArticles = NSMutableArray()
                
                for object in objects {
                    let newArtical = Article(parseObject: object as PFObject)
                    recievedArticles.addObject(newArtical)
                }
                
                if (pageIndex == 0){
                    self.articles.removeAllObjects()
                }
                self.articles.addObjectsFromArray(recievedArticles)
                
            } else {
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }
    
    func loadMoreDataFromParse(){
        currentPageIndex++;
        startLoadingDataFromParse(currentPageIndex)
    }
    
    func addArticle(newArticle:Article) {
        articles.addObject(newArticle)
    }
    
}
