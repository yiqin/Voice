//
//  SessionStreetImageTableViewCell.swift
//  Voice
//
//  Created by Yi Qin on 1/14/15.
//  Copyright (c) 2015 yiqin. All rights reserved.
//

import UIKit

class SessionStreetImageTableViewCell: UITableViewCell {
    
    var streetImageView : UIImageView
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        streetImageView = UIImageView()
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        streetImageView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame))
        streetImageView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        addSubview(streetImageView)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateCell(streetImage : StreetImage){
        streetImageView.image = streetImage.image.image
    }
}
