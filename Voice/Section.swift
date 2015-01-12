//
//  Section.swift
//  Voice
//
//  Created by Yi Qin on 1/12/15.
//  Copyright (c) 2015 yiqin. All rights reserved.
//

import UIKit

class Section: NSVoiceObject {
    
    var number : Int
    
    override init(parseObject:PFObject) {
        number = parseObject["number"] as Int
        
        super.init(parseObject:parseObject)
    }

}
