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
    var firstTimeLoad = true
    
    func updateFrame(maxY:CGFloat){
        self.frame = CGRectMake(0, maxY, DeviceManager.sharedInstance.screenWidth, DeviceManager.sharedInstance.screenHeight-maxY)
        
        if (firstTimeLoad) {
            self.addSubview(imagesRowsTableVC.view)
            firstTimeLoad = false
        }
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
