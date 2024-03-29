//
//  SessionArticleTableViewCell.swift
//  Voice
//
//  Created by Yi Qin on 1/14/15.
//  Copyright (c) 2015 yiqin. All rights reserved.
//

import UIKit

class SessionArticleTableViewCell: UITableViewCell {
    
    var coverImageView : ASImageNode
    var titleLabel : UILabel
    var tempView : UIView
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        coverImageView = ASImageNode()
        titleLabel = UILabel()
        tempView = UIView()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        coverImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))
        coverImageView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        coverImageView.contentMode = UIViewContentMode.ScaleToFill
        addSubview(coverImageView.view)
        
        tempView = UIView(frame: CGRectMake(10, 20, 300, 30))
        tempView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.75)
        // tempView.backgroundColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 0.85)
        
        addSubview(tempView)
        
        titleLabel.frame = CGRectMake(10, 20, 300, 30)
        titleLabel.textColor = UIColor.whiteColor()
        // titleLabel.font = UIFont(name: "TrebuchetMS-Bold", size: 17)
        titleLabel.font = UIFont.systemFontOfSize(15)
        
        titleLabel.shadowColor = UIColor.grayColor()
        titleLabel.shadowOffset = CGSizeMake(0.0, 0.0)
        
        addSubview(titleLabel)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func updateCell(article : Article){
        
        titleLabel.text = article.title
        titleLabel.sizeToFit()
        titleLabel.frame = CGRectMake(10+10, 20+8, CGRectGetWidth(titleLabel.frame), CGRectGetHeight(titleLabel.frame))
        tempView.frame = CGRectMake(0, 20, (CGRectGetMaxX(titleLabel.frame)+20), CGRectGetHeight(titleLabel.frame)+16)
        
        
        
        coverImageView.image = article.effectedImage
        
    }
    
    class func cellHeight()->CGFloat {
        return 125
    }

}
