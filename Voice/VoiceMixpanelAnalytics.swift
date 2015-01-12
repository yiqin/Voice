//
//  VoiceAnalytics.swift
//  Voice
//
//  Created by Yi Qin on 1/12/15.
//  Copyright (c) 2015 yiqin. All rights reserved.
//

import UIKit

class VoiceMixpanelAnalytics: NSObject {
    
    class func start() {
        let deviceName = UIDevice.currentDevice().name
        var mixpanel = Mixpanel.sharedInstance()
        mixpanel.people.set("DeviceName", to: deviceName)
        mixpanel.registerSuperProperties(["DeviceName":deviceName])
        mixpanel.track("Enter App.")
    }

}
