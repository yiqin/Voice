//
//  UserManager.swift
//  Voice
//
//  Created by yiqin on 10/27/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import Foundation

/**
 Manages all user information. It includes
*/
class UserManager: NSObject {
    
    
    class var sharedInstance : UserManager {
        struct Static {
            static let instance = UserManager()
        }
        return Static.instance
    }
    
    
}
