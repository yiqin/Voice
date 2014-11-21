//
//  AssistantHorizontalView.swift
//  Voice
//
//  Created by yiqin on 11/7/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

protocol AssistantHorizontalViewDelegate {
    func updateUpAnDownViewSize()
}

class AssistantHorizontalView: UIView, UIGestureRecognizerDelegate {
    
    let assistantInitPosition = CGFloat(300.0)
    let velocityLimitLevelOne = CGFloat(50.0)
    let velocityLimitLevelTwo = CGFloat(2000.0)
    
    var assistantHeight = CGFloat(70.0)
    var assistantWidth = DeviceManager.sharedInstance.screenWidth    // padding
    
    var lastLocation:CGPoint?
    var isVelocityDominate = true
    
    var panRecognizer = UIPanGestureRecognizer()
    
    var delegate:AssistantHorizontalViewDelegate?
    
    
    override init() {
        super.init()
        backgroundColor = UIColor.blueColor()
        
        lastLocation = self.center
        
        panRecognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        panRecognizer.delegate = self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /**
     At the end of the recognizer, update the location of AssistantHorizontalView with Animation.
     */
    func handlePan(recognizer:UIPanGestureRecognizer){
        // println("Handle Pan")
        
        var lastX = lastLocation?.x
        var lastY = lastLocation?.y
        var translation = recognizer.translationInView(self.superview!)
        
        // init animation variables
        var finalCenter = self.center
        var animtaionType = UIViewAnimationOptions.CurveEaseInOut
        var animtationTime = 0.5
        
        
        var velocity = recognizer.velocityInView(self.superview!)
        
        let middlePosition = (DeviceManager.sharedInstance.screenHeight-assistantHeight*0.5)*0.5
        
        println(velocity.y)
        if (velocity.y>velocityLimitLevelOne){
            
            if (velocity.y>velocityLimitLevelTwo){
                finalCenter = CGPointMake(lastX!, (DeviceManager.sharedInstance.screenHeight-assistantHeight*0.5))
                animtaionType = UIViewAnimationOptions.CurveEaseInOut
                animtationTime = 0.6
            }
            else {
                finalCenter = CGPointMake(lastX!, middlePosition)
                animtaionType = UIViewAnimationOptions.CurveLinear
                animtationTime = 0.4
                
                if((translation.y+lastY!) > middlePosition){
                    finalCenter = CGPointMake(lastX!, (DeviceManager.sharedInstance.screenHeight-assistantHeight*0.5))
                }
            }
            
        }
        else if (velocity.y<(-velocityLimitLevelOne)){
            
            if (velocity.y<(-velocityLimitLevelTwo)){
                finalCenter = CGPointMake(lastX!, assistantHeight*0.5)
                animtaionType = UIViewAnimationOptions.CurveEaseInOut
                animtationTime = 0.6
            }
            else {
                finalCenter = CGPointMake(lastX!, middlePosition)
                animtaionType = UIViewAnimationOptions.CurveLinear
                animtationTime = 0.4
                
                if((translation.y+lastY!) < middlePosition){
                    finalCenter = CGPointMake(lastX!, assistantHeight*0.5)
                }
            }
            
        }

        
        // Update the location of AssistantHorizontalView
        // Animation
        if (isVelocityDominate) {
            
            // self.isVelocityDominate = false
            
            UIView.animateWithDuration(animtationTime, delay: 0.0, options: animtaionType, animations: { () -> Void in
                
                self.center = finalCenter
                self.isVelocityDominate = true
                self.delegate?.updateUpAnDownViewSize()
                
                }) { (finished) -> Void in
                    
            }
        }

    }
    
    func updateFrame() {
        // repeat (update later.)
        assistantHeight = CGFloat(50.0)
        assistantWidth = DeviceManager.sharedInstance.screenWidth
        
        // Setup init position
        self.frame = CGRectMake(0, assistantInitPosition, assistantWidth, assistantHeight)
        
        // button
        let button = UIButton.buttonWithType(UIButtonType.System) as UIButton
        button.frame = CGRectMake(0, 0, assistantWidth, assistantHeight)
        
        button.setTitleColor(UIColor.cyanColor(), forState: UIControlState.Normal)
        
        button.setTitle("Voice ME", forState: UIControlState.Normal)
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        button.addGestureRecognizer(panRecognizer)
        
        self.addSubview(button)
    }
    
    /**
     Record start position into lastLocation.
     */
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        lastLocation = center
        return true
    }
    
    func buttonAction(sender:UIButton!) {
        println("Button tapped")
        SweetAlert().showAlert("Good job!", subTitle: "You clicked the button!", style: AlertStyle.Success)
    }
    
    class func height() -> CGFloat {
        return 50.0
    }
}
