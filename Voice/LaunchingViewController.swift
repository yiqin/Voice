//
//  LaunchingViewController.swift
//  Voice
//
//  Created by yiqin on 11/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class LaunchingViewController: UIViewController, UIWebViewDelegate {

    lazy var gifImageView:UIImageView = UIImageView()
    
    var loadTime = 0
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadSessionStreetImageTableViewCell", name: "reloadSessionStreetImageTableViewCell", object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        view.backgroundColor = UIColor(red: 35.0/255.0, green: 24.0/255.0, blue: 21.0/255.0, alpha: 1.0)
        gifImageView = UIImageView(frame: CGRectMake(0, 0, view.frame.width, view.frame.height))
        
        let tempScreenWidth = UIScreen.mainScreen().bounds.width
        let tempScreenHeight = UIScreen.mainScreen().bounds.height
        let ratio = tempScreenHeight/tempScreenWidth
        
        if (tempScreenHeight/tempScreenWidth >= 960.0/640.0) {
            let tempHeight = tempScreenWidth*960/640
            gifImageView.frame = CGRectMake(0, (view.frame.height-tempHeight)*0.5, view.frame.width, tempHeight)
        }
        
        gifImageView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
        view.addSubview(gifImageView)
        
        // Always get launching_1.gif
        /*
        if(VoiceUserDefaultsDataManager.sharedInstance.checkFirstTimeLoad()){
            gifImageView.setAnimatableImage(data: VoiceUserDefaultsDataManager.sharedInstance.getLaunchingGIF())
        }
        else {
            gifImageView.setAnimatableImage(named: "launching_1.gif")
        }
        */
        
        gifImageView.setAnimatableImage(named: "launching_1.gif")
        gifImageView.startAnimating()
        
        println(view.frame.size.width)
        println(view.frame.size.height)
        
    }
    
    func moveToMainViewController() {
        
        
        // var mainViewController = MainViewController(nibName:nil, bundle:nil)
        var mainViewController = CardsViewController(nibName:nil, bundle:nil)
        var tempNavigationController = SessionNavigationController(rootViewController: mainViewController)
        
        println("move To Main View Controller")
        self.gifImageView.stopAnimating()
        
        presentViewController(tempNavigationController, animated: true) { () -> Void in
            
            println("Finish move To Main View Controller")
            //
        }
        // self.navigationController?.pushViewController(mainViewController, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func reloadSessionStreetImageTableViewCell() {
        if (loadTime==0){
            var timer = NSTimer.scheduledTimerWithTimeInterval(0.00, target: self, selector: Selector("moveToMainViewController"), userInfo: nil, repeats: false)
            loadTime++
        }
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "reloadSessionStreetImageTableViewCell", object: nil)
    }
}
