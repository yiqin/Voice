//
//  ArticlesManager.swift
//  Voice
//
//  Created by yiqin on 10/22/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class ArticlesManager: NSObject {
    
    var articles : NSMutableArray = []
    
    class var sharedInstance : ArticlesManager {
        struct Static {
            static let instance = ArticlesManager()
        }
        return Static.instance
    }
    
    func startLoadingDataFromParse() {
        var query  = PFQuery(className: "Article")
        query.orderByAscending("updatedAt")
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                println("Load articles from Parse.com.")
                var recievedArticles = NSMutableArray()
                
                for object in objects {
                    let newArtical = Article(articlePFObject: object as PFObject)
                    recievedArticles.addObject(newArtical)
                }
                
                self.articles.removeAllObjects()
                self.articles.addObjectsFromArray(recievedArticles)
                
            } else {
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }
    
    func addArticle(newArticle:Article) {
        articles.addObject(newArticle)
    }
    
}
