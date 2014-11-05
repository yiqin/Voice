//
//  ArticleDetailManager.swift
//  Voice
//
//  Created by yiqin on 11/3/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

/**
 It contains only one article. All article blocks are saved into articleBlocks.
*/
class ArticleDetailManager: NSObject {
    
    var articleBlocks : NSMutableArray = []
    
    class var sharedInstance : ArticleDetailManager {
        struct Static {
            static let instance = ArticleDetailManager()
        }
        return Static.instance
    }
    
    func addArticleBlock(articleBlock:ArticleBlock){
        articleBlocks.addObject(articleBlock)
    }
    
    func removeArticleBlocks(){
        articleBlocks.removeAllObjects()
    }
}
