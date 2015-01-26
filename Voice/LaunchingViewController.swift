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
        
        // Only two places are need to check the Internet.
        if(!CheckConnectivity.isConnectedToNetwork()){
            
        }
        else {
            SessionsManager.sharedInstance.startLoadingDataFromParse(0, completionClosure: { (success) -> () in
                if(success){
                    
                }
                else {
                    // No need. It's in AppDelegate
                    // var timer = NSTimer.scheduledTimerWithTimeInterval(0.50, target: self, selector: Selector("noConnection"), userInfo: nil, repeats: false)
                }
            })
        }
    }
    
    func moveToMainViewController() {
        gifImageView.stopAnimating()
        
        
        
        // var mainViewController = MainViewController(nibName:nil, bundle:nil)
        var mainViewController = NewMainViewController(nibName:nil, bundle:nil)
        var tempNavigationController = SessionNavigationController(rootViewController: mainViewController)
        
        
        
        self.presentViewController(tempNavigationController, animated: true) { () -> Void in
            
        }
        
        // self.navigationController?.pushViewController(mainViewController, animated: true)
    }
    
    func noConnection() {
        let alertView = UIAlertView(title: "Oops", message: "Please check your internet.", delegate: self, cancelButtonTitle: "Cancel")
        alertView.show()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func reloadSessionStreetImageTableViewCell() {
        if (DeviceManager.sharedInstance.loadTime==0){
            var timer = NSTimer.scheduledTimerWithTimeInterval(1.00, target: self, selector: Selector("moveToMainViewController"), userInfo: nil, repeats: false)
            DeviceManager.sharedInstance.loadTime++
        }
    }
}
