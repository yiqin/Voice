//
//  AssistantView.swift
//  Voice
//
//  Created by yiqin on 10/22/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class AssistantView: UIView {
    
    let inclinedAngle = 8*M_PI/180;
    var inclineHeight = CGFloat(0.0);
    var assistantHeight = CGFloat(40.0)
    var assistantWidth = DeviceManager.sharedInstance.screenWidth    // padding
    
    var testString = UILabel()
    var testButton = UIButton()
    
    override init() {
        super.init(frame: CGRect(x: 0, y: DeviceManager.sharedInstance.screenHeight*0.5, width: assistantWidth, height: assistantHeight))    // default value, it's not correct.
        self.backgroundColor = UIColor.clearColor()

        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateFrame() {
        // Had to repeat
        assistantHeight = CGFloat(40.0)
        assistantWidth = DeviceManager.sharedInstance.screenWidth   // padding
        
        inclineHeight = CGFloat(tan(inclinedAngle))*assistantWidth
        println(inclineHeight)
        
        self.frame = CGRectMake(0, DeviceManager.sharedInstance.screenHeight*0.5, assistantWidth, assistantHeight*2)
        
        /************************************/
        // The image quality is going down when rotating
        testString = UILabel(frame: CGRectMake(0, 2*assistantHeight-inclineHeight, assistantWidth, assistantHeight))
        // self.testString.center = self.center
        testString.backgroundColor = UIColor.redColor()
        testString.text = "testing"
        testString.textAlignment = NSTextAlignment.Center
        
        
        // testString.layer.anchorPoint = CGPointMake(0, 1)
        
        testString.transform = CGAffineTransformMakeRotation(CGFloat(-inclinedAngle))
        // let pt = CGPointMake(0, assistantHeight-inclineHeight)
        // testString.transform = CGAffineTransformMakeRotationAt(CGFloat(-inclinedAngle), pt: pt)
        
        self.addSubview(testString)
    }
    
    
    func CGAffineTransformMakeRotationAt(angle:CGFloat, pt:CGPoint) -> CGAffineTransform{
        let fx = pt.x;
        let fy = pt.y;
        let fcos = cos(angle);
        let fsin = sin(angle);
        return CGAffineTransformMake(fcos, fsin, -fsin, fcos, fx - fx * fcos + fy * fsin, fy - fx * fsin - fy * fcos);
    }
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
        let ctx = UIGraphicsGetCurrentContext()
        
        CGContextBeginPath(ctx)
        CGContextMoveToPoint(ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect)-inclineHeight)
        
        CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect))
        CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMaxY(rect))
        CGContextAddLineToPoint(ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect))
        CGContextClosePath(ctx)
        
        CGContextSetRGBFillColor(ctx, 1, 1, 0, 1)
        CGContextFillPath(ctx)
    }
    

}
