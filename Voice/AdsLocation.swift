//
//  AdsLocation.swift
//  Voice
//
//  Created by yiqin on 10/27/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class AdsLocation: NSVoiceObject {
    
    var cityName: String
    var stateName: String
    
    init(parseObject:PFObject) {
        super.init(parseObject:parseObject)
        
        cityName = parseObject["cityName"] as String
        stateName = parseObject["stateName"] as String
    };
}
