//
//  AssistantView.swift
//  Voice
//
//  Created by yiqin on 10/22/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class AssistantView: UIView {
    
    let inclinedAngle = 10.0;
    // Default values
    var assistantHeight = CGFloat(30.0)
    var assistantWidth = DeviceManager.sharedInstance.screenWidth*1.4    // padding
    
    var testString = UILabel()
    
    override init() {
        super.init(frame: CGRect(x: 0, y: DeviceManager.sharedInstance.screenHeight*0.5, width: assistantWidth, height: assistantHeight))    // default value, it's not correct.
        self.backgroundColor = UIColor.yellowColor()
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateFrame() {
        // Had to repeat
        assistantHeight = CGFloat(30.0)
        assistantWidth = DeviceManager.sharedInstance.screenWidth*1.4    // padding
        
        self.frame = CGRectMake(-assistantWidth*0.2, DeviceManager.sharedInstance.screenHeight*0.5, assistantWidth, assistantHeight)
        
        /************************************/
        // The image quality is going down when rotating
        self.testString = UILabel(frame: CGRectMake(100, 0, 100, 20))
        self.testString.backgroundColor = UIColor.redColor()
        self.testString.text = "testing"
        self.addSubview(testString)

        
        // must be after updating frame.
        self.transform = CGAffineTransformMakeRotation(CGFloat(-inclinedAngle*M_PI/180.0))
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
