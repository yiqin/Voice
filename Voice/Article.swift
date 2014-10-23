//
//  News.swift
//  Voice
//
//  Created by yiqin on 10/22/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class Article: NSObject {
    
    var title: String = ""
    var briefDescription: String = ""
    
    
    
    init(articlesPFObject:PFObject) {
        title = articlesPFObject["title"] as String
        briefDescription = articlesPFObject["briefDescription"] as String
    };
    
}
