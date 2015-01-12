//
//  SectionsManager.swift
//  Voice
//
//  Created by Yi Qin on 1/12/15.
//  Copyright (c) 2015 yiqin. All rights reserved.
//

import Cocoa

class SectionsManager: NSObject {
    
    
    class var sharedInstance : ArticlesManager {
        struct Static {
            static let instance = ArticlesManager()
        }
        return Static.instance
    }
    
    
    
    

}
