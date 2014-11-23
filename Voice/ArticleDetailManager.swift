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
    
    func addAllArticleBlcoks(savedArticleBlocks: NSMutableArray){
        articleBlocks = savedArticleBlocks
    }
    
    
    /**
     More checks are required now.
    */
    func checkWhetherDataAreReady() -> Bool {
        
        if (articleBlocks.count == 0) {
            return false
        }
        
        for articleBlock in articleBlocks {
            // println((articleBlock as ArticleBlock).isHtmlLoading)
            if((articleBlock as ArticleBlock).isHtmlLoading == false){
                return false
            }
        }
        return true
    }
}
