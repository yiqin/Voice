//
//  ViewController.swift
//  Voice
//
//  Created by yiqin on 10/17/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit
import Parse

class MainViewController: UIViewController, UIGestureRecognizerDelegate {

    var assistantView = AssistantView()
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
                
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
    }
    
    override func viewDidLayoutSubviews() {
        // Device Size First.
        DeviceManager.sharedInstance.setDeviceSize()
        println(DeviceManager.sharedInstance.screenWidth)
        println(DeviceManager.sharedInstance.screenHeight)
        
        assistantView.updateFrame()
        
        
        // let recognizer = UITapGestureRecognizer(target: self, action:"handleTap:")
        // recognizer.delegate = self
        // assistantView.addGestureRecognizer(recognizer)
        assistantView.recognizer.delegate = self
        
        //
        self.view.addSubview(assistantView)
    }
    
    func handleTap(recognizer:UITapGestureRecognizer){
        println("MainViewController: Tap")
        
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        println("MainViewController: tap should begin")
        return true
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        println("MainViewController: tap should receive")
        return true
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

