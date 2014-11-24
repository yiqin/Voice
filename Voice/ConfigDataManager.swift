//
//  ConfigDataManager.swift
//  Voice
//
//  Created by yiqin on 11/23/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

/**
 Configuration data from Parse.com
*/
class ConfigDataManager: NSObject {
    
    class var sharedInstance : ConfigDataManager {
        struct Static {
            static let instance = ConfigDataManager()
        }
        return Static.instance
    }
    
    
}
