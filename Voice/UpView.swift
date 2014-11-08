//
//  UpView.swift
//  Voice
//
//  Created by yiqin on 10/22/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class UpView: UIView {

    var firstTimeLoad = true
    var articlesTableVC = ArticlesTableViewController(style: UITableViewStyle.Plain)
    
    override init() {
        super.init()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateFrame(maxY:CGFloat){
        backgroundColor = UIColor.brownColor()
        
        
        UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveEaseOut, animations: { () -> Void in
            
            self.frame = CGRectMake(0, 0, DeviceManager.sharedInstance.screenWidth, maxY)
            
            }) { (finished) -> Void in
                
        }
        
        
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
