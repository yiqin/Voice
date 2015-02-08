//
//  PageViewDataManager.swift
//  Voice
//
//  Created by Yi Qin on 2/7/15.
//  Copyright (c) 2015 yiqin. All rights reserved.
//

import UIKit

class PageViewsDataManager: NSObject {
    
    var localPageViewsList : NSMutableSet = NSMutableSet()
    
    class var sharedInstance : PageViewsDataManager {
        struct Static {
            static let instance = PageViewsDataManager()
        }
        return Static.instance
    }
    
    func addPageView(userObjectId: String){
        localPageViewsList.addObject(userObjectId)
    }
    
    func checkPageView(userObjectId:String)->Bool{
        return localPageViewsList.containsObject(userObjectId)
    }
}

