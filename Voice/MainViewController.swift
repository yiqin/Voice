//
//  ViewController.swift
//  Voice
//
//  Created by yiqin on 10/17/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit
import Parse

class MainViewController: UIViewController, UIGestureRecognizerDelegate, AssistantHorizontalViewDelegate, ArticlesTableViewControllerDelegate {

    var assistantHorizontalView = AssistantHorizontalView()
    /// Is called everytime we reload the table. A firstTimeLoad is necessary
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
        super.viewDidAppear(animated)
    }
    
    override func viewDidLayoutSubviews() {
        if firstTimeLoad == true {
            // Device Size First.
            DeviceManager.sharedInstance.setDeviceSize()
            println(DeviceManager.sharedInstance.screenWidth)
            println(DeviceManager.sharedInstance.screenHeight)
            
            assistantHorizontalView.updateFrame()     // updateFrame method has be here
            assistantHorizontalView.tapRecognizer.delegate = self     // Three delegate
            assistantHorizontalView.panRecognizer.delegate = self
            assistantHorizontalView.delegate = self
            
            upView.updateFrame(CGRectGetMaxY(assistantHorizontalView.frame))
            downView.updateFrame(CGRectGetMaxY(assistantHorizontalView.frame))
            
            
            upView.articlesTableVC.delegate = self
            
            self.view.addSubview(upView)
            self.view.addSubview(downView)
            self.view.addSubview(assistantHorizontalView)
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
        upView.updateFrame(CGRectGetMaxY(assistantHorizontalView.frame))
        upView.setNeedsDisplay()
        downView.updateFrame(CGRectGetMaxY(assistantHorizontalView.frame))
        downView.setNeedsDisplay()
    }
    
    func moveToSelectArticle(selectedArticle:Article) {
        var articleDetailViewController = ArticleDetailViewController(nibName:nil, bundle:nil, article: selectedArticle)
        // articleDetailViewController.selectedArticle = selectedArticle;
        self.navigationController?.pushViewController(articleDetailViewController, animated: true)
    }

}

