//
//  SessionStreetImageTableViewCell.swift
//  Voice
//
//  Created by Yi Qin on 1/14/15.
//  Copyright (c) 2015 yiqin. All rights reserved.
//

import UIKit

class SessionStreetImageTableViewCell: UITableViewCell {
    
    var streetImageView : PFImageView
    var titleView : UIView
    var titleLabel: UILabel
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        streetImageView = PFImageView()
        titleView = UIView()
        titleLabel = UILabel()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        streetImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))
        streetImageView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        addSubview(streetImageView)
        
        titleView.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.5)
        titleView.frame = CGRectMake(0, DeviceManager.sharedInstance.screenHeight*0.6, DeviceManager.sharedInstance.screenWidth, 50)
        addSubview(titleView)
        
        titleLabel = UILabel(frame:CGRectMake(25, 0, DeviceManager.sharedInstance.screenWidth-50, 50))
        titleLabel.font = UIFont.systemFontOfSize(11.5)
        titleLabel.textAlignment = NSTextAlignment.Center
        titleLabel.numberOfLines = 2
        titleView.addSubview(titleLabel)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateCell(streetImage : StreetImage, session : Session){
        titleLabel.text = session.title
        streetImageView.file = session.streetImage.imagePFFile
        if(session.isLoading){
            SVProgressHUD.show()
            streetImageView.loadInBackground({ (image:UIImage!, error:NSError!) -> Void in
                println("load ................")
                self.reloadInputViews()
                SVProgressHUD.dismiss()
                // 
            })
        }
        else {
            streetImageView.image = streetImage.image.image
        }
    }
}
