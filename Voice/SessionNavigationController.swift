//
//  SessionNavigationController.swift
//  Voice
//
//  Created by Yi Qin on 1/26/15.
//  Copyright (c) 2015 yiqin. All rights reserved.
//

import UIKit

class SessionNavigationController: UINavigationController {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nil, bundle: nil)
    }
    
    override init(rootViewController: UIViewController) {
        
        super.init(rootViewController: rootViewController)
        
        navigationBar.barTintColor = UIColor.whiteColor()
        navigationBar.tintColor = UIColor.whiteColor()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return false
    }

}
