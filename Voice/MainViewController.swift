//
//  ViewController.swift
//  Voice
//
//  Created by yiqin on 10/17/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit
import Parse

class MainViewController: UIViewController, UIGestureRecognizerDelegate, AssistantViewDelegate, UpViewDelegate {

    var assistantView = AssistantView()
    var firstTimeLoad = true
    
    var upView = UpView()
    var downView = DownView()
    
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
        // Is called everytime we reload the table. A firstTimeLoad is necessary
        if firstTimeLoad == true {
            // Device Size First.
            DeviceManager.sharedInstance.setDeviceSize()
            println(DeviceManager.sharedInstance.screenWidth)
            println(DeviceManager.sharedInstance.screenHeight)
            
            assistantView.updateFrame()     // updateFrame method has be here
            assistantView.tapRecognizer.delegate = self     // Three delegate
            assistantView.panRecognizer.delegate = self
            assistantView.delegate = self
            
            upView.updateFrame(CGRectGetMaxY(assistantView.frame))
            downView.updateFrame(CGRectGetMaxY(assistantView.frame))
            
            
            // upView.articlesTableVC
            // upView.articlesTableVC.delegate = self
            upView.delegate = self
            
            self.view.addSubview(upView)
            self.view.addSubview(downView)
            self.view.addSubview(assistantView)
            firstTimeLoad = false
        }
    }
    
    /*******************/
    /*
    func handleTap(recognizer:UITapGestureRecognizer){
        println("MainViewController: Tap")
        
    }
    
    func gestureRecognizerShouldBegin(gestureRecognizer: UITapGestureRecognizer) -> Bool {
        println("MainViewController: tap should begin")
        assistantView.backgroundColor = UIColor.yellowColor()
        return true
    }

    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldReceiveTouch touch: UITouch) -> Bool {
        println(gestureRecognizer)
        println("MainViewController: tap should receive")
        // assistantView.backgroundColor = UIColor.blueColor()
        return true
    }
    */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateUpAnDownViewSize() {
        // println("Delegate works")
        upView.updateFrame(CGRectGetMaxY(assistantView.frame))
        upView.setNeedsDisplay()
        downView.updateFrame(CGRectGetMaxY(assistantView.frame))
        downView.setNeedsDisplay()
    }
    
    func moveToSelectArticleFromUpView() {
        
        
        let articleDetailViewController = ArticleDetailViewController(nibName:nil, bundle:nil)
        self.navigationController?.pushViewController(articleDetailViewController, animated: true)

    }

}

