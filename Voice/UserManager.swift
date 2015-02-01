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
    
    class func configureRole(userType : String) {
        var tempQuery = PFQuery(className: "_Role")
        tempQuery.whereKey("name", equalTo: userType)
        tempQuery.findObjectsInBackgroundWithBlock { (objects:[AnyObject]!, error:NSError!) -> Void in
            // It supports to be only one return object.
            println("helllooooooooooooo")
            println(objects.count)
            for object in objects {
                var tempRole: PFRole = object as PFRole
                println(tempRole["name"])
                var userRelation = tempRole.relationForKey("users")
                userRelation.addObject(PFUser.currentUser())
                tempRole.saveInBackgroundWithBlock({ (successed : Bool!, error : NSError!) -> Void in
                    println("Something woong")
                    if((error) != nil){
                        println(error)
                    }
                })
            }
        }

    }
    
}
