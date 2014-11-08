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
    var imagesRowsTableVC = ImagesRowsTableViewController(style: UITableViewStyle.Plain)
    
    func updateFrame(maxY:CGFloat){
        backgroundColor = UIColor.grayColor()
        
        
        UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveEaseOut, animations: { () -> Void in
            
            self.frame = CGRectMake(0, maxY, DeviceManager.sharedInstance.screenWidth, DeviceManager.sharedInstance.screenHeight-maxY)
            
            }) { (finished) -> Void in
                
        }
        
        
        self.addSubview(imagesRowsTableVC.view)
        loadImagesRowsTableVC(maxY)
    }
    
    func loadImagesRowsTableVC(maxY:CGFloat) {
        imagesRowsTableVC.view.frame = CGRectMake(0, 0, DeviceManager.sharedInstance.screenWidth, DeviceManager.sharedInstance.screenHeight-maxY)
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
