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
    var inclineHeight = CGFloat(0.0)
    var assistantHeight = CGFloat(40.0)
    var assistantWidth = DeviceManager.sharedInstance.screenWidth    // padding
    
    var testString = UILabel()
    var testButton = UIButton()
    var testView = UIView()
    
    
    
    var recognizer = UIGestureRecognizer()
    
    
    
    override init() {
        super.init(frame: CGRect(x: 0, y: DeviceManager.sharedInstance.screenHeight*0.5, width: assistantWidth, height: assistantHeight))    // default value, it's not correct.
        self.backgroundColor = UIColor.clearColor() // set to clear color later
        
        recognizer = UITapGestureRecognizer(target: self, action:"handleTap:")
        self.addGestureRecognizer(recognizer)
    }
    
    
    func handleTap(recognizer:UITapGestureRecognizer){
        println("Tap")
        
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
        testString = UILabel(frame: CGRectMake(-20, assistantHeight-inclineHeight+18, assistantWidth+40, assistantHeight))  // some number is here.
        // self.testString.center = self.center
        // testString.backgroundColor = UIColor.redColor()
        testString.text = "testing"
        testString.textAlignment = NSTextAlignment.Center
        
        testString.layer.anchorPoint = CGPointMake(0.5, 0.5)
        testString.transform = CGAffineTransformMakeRotation(CGFloat(-inclinedAngle))
        
        
        /************************************/
        // This method doesn't work.
        // let pt = CGPointMake(0, assistantHeight-inclineHeight)
        // testString.transform = CGAffineTransformMakeRotationAt(CGFloat(-inclinedAngle), pt: pt)
        
        self.addSubview(testString)
        
        testView = UIView(frame: CGRectMake(-20, assistantHeight-inclineHeight+18, assistantWidth+40, assistantHeight))  // some number is here.
        println(CGRectGetMaxY(self.testView.frame))
        
        
        /************************************/
        // testView.backgroundColor = UIColor.blueColor()
        testView.transform = CGAffineTransformMakeRotation(CGFloat(-inclinedAngle))
        self.addSubview(testView)
        
        println(CGRectGetMaxY(self.testView.frame))
        
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
        
        drawTriangle(rect)
    }
    
    func drawTriangle(rect: CGRect){
        var path = CGPathCreateMutable()
        CGPathMoveToPoint(path, nil, CGRectGetMinX(rect), CGRectGetMaxY(rect))
        CGPathAddLineToPoint(path, nil, CGRectGetMaxX(rect), CGRectGetMaxY(rect)-inclineHeight+6)   // some number is here.
        CGPathAddLineToPoint(path, nil, CGRectGetMaxX(rect), CGRectGetMaxY(rect))
        CGPathAddLineToPoint(path, nil, CGRectGetMinX(rect), CGRectGetMaxY(rect))
        
        var shapeLayer = CAShapeLayer()
        shapeLayer.path = path
        shapeLayer.fillColor = UIColor.greenColor().CGColor
        self.layer.addSublayer(shapeLayer)
        
    }
    
    

}
