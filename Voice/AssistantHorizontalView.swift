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

    var assistantHeight = CGFloat(40.0)
    var assistantWidth = DeviceManager.sharedInstance.screenWidth    // padding
    
    var testString = UILabel()
    var testButton = UIButton()
    var testView = UIView()
    
    var lastLocation:CGPoint?  // Why init here?
    
    var tapRecognizer = UIGestureRecognizer()   // Update to tap later
    var panRecognizer = UIPanGestureRecognizer()
    
    
    var delegate:AssistantHorizontalViewDelegate?
    
    
    override init() {
        super.init(frame: CGRect(x: 0, y: DeviceManager.sharedInstance.screenHeight*0.5, width: assistantWidth, height: assistantHeight))    // default value, it's not correct.
        backgroundColor = UIColor.clearColor()
        
        lastLocation = self.center
        
        tapRecognizer = UITapGestureRecognizer(target: self, action:"handleTap:")
        panRecognizer = UIPanGestureRecognizer(target: self, action: "handlePan:")
        
        self.addGestureRecognizer(tapRecognizer)
        self.addGestureRecognizer(panRecognizer)
    }
    
    
    func handleTap(recognizer:UITapGestureRecognizer){
        println("Handle Tap")
        
    }
    
    func handlePan(recognizer:UIPanGestureRecognizer){
        // println("Handle Pan")
        
        var lastX = lastLocation?.x
        var lastY = lastLocation?.y
        var translation = recognizer.translationInView(self.superview!)
        center = CGPointMake(lastX!, translation.y+lastY!)
        
        
        delegate?.updateUpAnDownViewSize()
    }
    
    /**************************/
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        lastLocation = center
        backgroundColor = UIColor.clearColor()
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        backgroundColor = UIColor.clearColor()
    }
    
    /*
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
    // It didn't work
    backgroundColor = UIColor.redColor()
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
    backgroundColor = UIColor.yellowColor()
    
    }
    */
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateFrame() {
        // Had to repeat
        assistantHeight = CGFloat(40.0)
        assistantWidth = DeviceManager.sharedInstance.screenWidth   // padding
        
        
        self.frame = CGRectMake(0, 0, assistantWidth, assistantHeight)
        
        testString = UILabel(frame: CGRectMake(0, 0, assistantWidth, assistantHeight))
        testString.center = self.center
        testString.backgroundColor = UIColor.redColor()
        testString.text = "Voice"
        testString.textAlignment = NSTextAlignment.Center
        
        addSubview(testString)
        
    }
    
}
