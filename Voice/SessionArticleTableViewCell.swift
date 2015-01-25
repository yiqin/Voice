//
//  SessionArticleTableViewCell.swift
//  Voice
//
//  Created by Yi Qin on 1/14/15.
//  Copyright (c) 2015 yiqin. All rights reserved.
//

import UIKit

class SessionArticleTableViewCell: UITableViewCell {
    
    var coverImageView : UIImageView
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        coverImageView = UIImageView()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        coverImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))
        coverImageView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        coverImageView.contentMode = UIViewContentMode.ScaleToFill
        addSubview(coverImageView)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateCell(article : Article){
        let tempImage = article.briefImage.image
        let tempImageWidth = tempImage?.size.width
        let tempImageHeight = tempImage?.size.height
        let ratio = DeviceManager.sharedInstance.screenWidth/tempImageWidth!
        
        let scaledTempImage = tempImage?.scaleToSize(CGSizeMake(DeviceManager.sharedInstance.screenWidth, tempImageHeight!*ratio))
        let croppedTempImage = scaledTempImage?.cropToSize(CGSizeMake(DeviceManager.sharedInstance.screenWidth, 150), usingMode: NYXCropModeCenter)
        
        let blurTempImage = croppedTempImage?.gaussianBlurWithBias(0)
        
        coverImageView.image = blurTempImage
    }
    
    class func cellHeight()->CGFloat {
        return 150
    }

}
