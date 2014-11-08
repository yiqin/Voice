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

class AssistantHorizontalView: UIView {
    
    var assistantHeight = CGFloat(50.0)
    var assistantWidth = DeviceManager.sharedInstance.screenWidth    // padding
    
    var testString = UILabel()
    var testButton = UIButton()
    var testView = UIView()
    
    var lastLocation:CGPoint?  // Why init here?
    
    var tapRecognizer = UIGestureRecognizer()   // Update to tap later
    var panRecognizer = UIPanGestureRecognizer()
    
    
    var delegate:AssistantHorizontalViewDelegate?
    
    
    override init() {
        super.init()    // default value, it's not correct.
        backgroundColor = UIColor.blueColor()
        
        lastLocation = self.center
        
        tapRecognizer = UITapGestureRecognizer(target: self, action:"handleTap:")
        panRecognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        
        // self.addGestureRecognizer(tapRecognizer)
        self.addGestureRecognizer(panRecognizer)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func handleTap(recognizer:UITapGestureRecognizer){
        println("Handle Tap")
        
    }
    
    func handlePan(recognizer:UIPanGestureRecognizer){
        // println("Handle Pan")
        
        var lastX = lastLocation?.x
        var lastY = lastLocation?.y
        var translation = recognizer.translationInView(self.superview!)
        
        // Update the location of AssistantHorizontalView
        // Animation
        UIView.animateWithDuration(0.25, delay: 0.05, options: .CurveEaseInOut, animations: { () -> Void in
        
            self.center = CGPointMake(lastX!, translation.y+lastY!)
            self.delegate?.updateUpAnDownViewSize()
            
        }) { (finished) -> Void in
            
        }
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        lastLocation = center
        backgroundColor = UIColor.blueColor()
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        backgroundColor = UIColor.blueColor()
    }
    
    func updateFrame() {
        // repeat (update later.)
        assistantHeight = CGFloat(50.0)
        assistantWidth = DeviceManager.sharedInstance.screenWidth
        
        self.frame = CGRectMake(0, 300, assistantWidth, assistantHeight)
        
        testButton = UIButton(frame: CGRectMake(0, 0, assistantWidth, assistantHeight))
        testButton.backgroundColor = UIColor.redColor()
        // testButton.titleLabel?.text = "Voice Me"
        // testButton.textAlignment = NSTextAlignment.Center
        
        // self.addSubview(testButton)
    }
    
    class func height() -> CGFloat {
        return 50.0
    }
}
