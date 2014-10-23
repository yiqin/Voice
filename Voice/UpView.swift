//
//  UpView.swift
//  Voice
//
//  Created by yiqin on 10/22/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class UpView: UIView {

    var newsTableVC = ArticlesTableViewController(style: UITableViewStyle.Plain)

    func updateFrame(maxY:CGFloat){
        backgroundColor = UIColor.brownColor()
        frame = CGRectMake(0, 0, DeviceManager.sharedInstance.screenWidth, maxY)
        self.addSubview(newsTableVC.view)
        loadNewsTableVC()
    }
    
    func loadNewsTableVC() {
        newsTableVC.view.frame = CGRectMake(0, 0, DeviceManager.sharedInstance.screenWidth, DeviceManager.sharedInstance.screenHeight)
        
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
