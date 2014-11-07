//
//  VMImageView.swift
//  Voice
//
//  Created by yiqin on 11/7/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

/**
 Handle image downloading from Parse.com
 */
class VMImageView: PFImageView {
    
    /**
     check whether the image is downloading.
      - true: downloading. 
      - false: not downloading.
     */
    var isLoading:Bool
    
    override init() {
        isLoading = false
        super.init()
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
