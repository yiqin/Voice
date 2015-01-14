//
//  SessionArticleTableViewCell.swift
//  Voice
//
//  Created by Yi Qin on 1/14/15.
//  Copyright (c) 2015 yiqin. All rights reserved.
//

import UIKit

class SessionArticleTableViewCell: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    class func cellHeight()->CGFloat {
        return 100
    }

}
