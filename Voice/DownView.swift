//
//  Down.swift
//  Voice
//
//  Created by yiqin on 10/22/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class DownView: UIView {

    // For testing
    var articlesTableVC = ArticlesTableViewController(style: UITableViewStyle.Plain)
    
    func updateFrame(minY:CGFloat){
        backgroundColor = UIColor.grayColor()
        frame = CGRectMake(0, minY, DeviceManager.sharedInstance.screenWidth, DeviceManager.sharedInstance.screenHeight-minY)
        self.addSubview(articlesTableVC.view)
        loadArticlesTableVC(minY)
    }
    
    func loadArticlesTableVC(minY:CGFloat) {
        articlesTableVC.view.frame = CGRectMake(0, 0, DeviceManager.sharedInstance.screenWidth, DeviceManager.sharedInstance.screenHeight-minY)
    }
    
    
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */

}
