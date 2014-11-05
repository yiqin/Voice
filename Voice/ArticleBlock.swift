//
//  ArticleBlock.swift
//  Voice
//
//  Created by yiqin on 11/3/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class ArticleBlock:NSVoiceObject{
    
    var text:String
    
    
    override init(parseObject:PFObject) {
        
        text = parseObject["text"] as String
        
        super.init(parseObject:parseObject)
    };

}
