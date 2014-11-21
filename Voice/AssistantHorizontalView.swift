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
    
    var assistantHeight = CGFloat(50.0)
    var assistantWidth = DeviceManager.sharedInstance.screenWidth    // padding
    
    var lastLocation:CGPoint?  // Why init here?
    
    var panRecognizer = UIPanGestureRecognizer()
    
    // var isVelocityDominate = false
    
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
        
        
        var finalCenter: CGPoint
        var animtaionType:UIViewAnimationOptions

        if ((translation.y+lastY!)<100){
            finalCenter = CGPointMake(lastX!, assistantHeight*0.5)
            animtaionType = UIViewAnimationOptions.CurveLinear
        }
        else if ((translation.y+lastY!)>450){
            finalCenter = CGPointMake(lastX!, (DeviceManager.sharedInstance.screenHeight-assistantHeight*0.5))
            animtaionType = UIViewAnimationOptions.CurveLinear
        }
        else {
            finalCenter = CGPointMake(lastX!, translation.y+lastY!)
            animtaionType = UIViewAnimationOptions.CurveEaseInOut
        }
        
        // Update the location of AssistantHorizontalView
        // Animation
        UIView.animateWithDuration(0.20, delay: 0.00, options: animtaionType, animations: { () -> Void in
            
            self.center = finalCenter
            self.delegate?.updateUpAnDownViewSize()
            
            }) { (finished) -> Void in
                
        }

    }
    
    func updateFrame() {
        // repeat (update later.)
        assistantHeight = CGFloat(50.0)
        assistantWidth = DeviceManager.sharedInstance.screenWidth
        
        self.frame = CGRectMake(0, 300, assistantWidth, assistantHeight)
        
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
        
        /*
        let alertView = UIAlertView(title: "Voice ME", message: "More features are on the way.", delegate: self, cancelButtonTitle: "OK")
        
        alertView.show()
        */
        SweetAlert().showAlert("Good job!", subTitle: "You clicked the button!", style: AlertStyle.Success)
        
    }
    
    class func height() -> CGFloat {
        return 50.0
    }
}
