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
    lazy var pngImageView:UIImageView = UIImageView()
    
    var loadTime = 0
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tempScreenWidth = UIScreen.mainScreen().bounds.width
        let tempScreenHeight = UIScreen.mainScreen().bounds.height
        let ratio = tempScreenHeight/tempScreenWidth
        
        gifImageView = UIImageView(frame: CGRectMake(0, 0, tempScreenWidth, tempScreenHeight))
        gifImageView.frame = CGRectMake(0, 0, tempScreenWidth, tempScreenHeight)
        gifImageView.contentMode = UIViewContentMode.ScaleAspectFill
        gifImageView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
        gifImageView.backgroundColor = UIColor.clearColor()
        view.addSubview(gifImageView)
        
        pngImageView = UIImageView(frame: CGRectMake(0, 0, tempScreenWidth, tempScreenHeight))
        pngImageView.contentMode = UIViewContentMode.ScaleAspectFill
        pngImageView.autoresizingMask = UIViewAutoresizing.FlexibleWidth |  UIViewAutoresizing.FlexibleHeight
        pngImageView.image = UIImage(named: "coming_soon_background")
        pngImageView.backgroundColor = UIColor.clearColor()
        view.insertSubview(pngImageView, belowSubview: gifImageView)
        
        gifImageView.setAnimatableImage(named: "coming_soon.gif")
        gifImageView.startAnimating()
        
        
        SessionsManager.sharedInstance.startLoadingDataFromParse(0, completionClosure: { (success) -> () in
            if(success){
                var timer = NSTimer.scheduledTimerWithTimeInterval(1.00, target: self, selector:"moveToMainViewController", userInfo: nil, repeats: false)
            }
            else {
                
            }
        })
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    func moveToMainViewController() {
        
        let cardsViewController: CardsViewController = storyboard?.instantiateViewControllerWithIdentifier("CardsViewController") as CardsViewController
        
        // var mainViewController = MainViewController(nibName:nil, bundle:nil)
        // var mainViewController = CardsViewController(nibName:nil, bundle:nil)
        // var tempNavigationController = SessionNavigationController(rootViewController: mainViewController)
        
        println("move To Main View Controller")
        self.gifImageView.stopAnimating()
        
        presentViewController(cardsViewController, animated: true) { () -> Void in
            println("Finish move To Main View Controller")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
