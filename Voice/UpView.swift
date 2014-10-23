//
//  UpView.swift
//  Voice
//
//  Created by yiqin on 10/22/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class UpView: UIView {

    var articlesTableVC = ArticlesTableViewController(style: UITableViewStyle.Plain)

    func updateFrame(maxY:CGFloat){
        backgroundColor = UIColor.brownColor()
        frame = CGRectMake(0, 0, DeviceManager.sharedInstance.screenWidth, maxY)
        self.addSubview(articlesTableVC.view)
        loadArticlesTableVC(maxY)
    }
    
    func loadArticlesTableVC(maxY:CGFloat) {
        articlesTableVC.view.frame = CGRectMake(0, 0, DeviceManager.sharedInstance.screenWidth, maxY)
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
