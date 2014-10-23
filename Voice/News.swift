//
//  News.swift
//  Voice
//
//  Created by yiqin on 10/22/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class News: NSObject {
    
    var title: String = ""
    var briefDescription: String = ""
    
    
    
    convenience init(newsPFObject:PFObject) {
        self.init()
        
        title = newsPFObject["title"] as String
        briefDescription = newsPFObject["briefDescription"] as String
        
        
    };
    
}
