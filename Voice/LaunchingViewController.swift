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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        gifImageView = UIImageView(frame: CGRectMake(0, 0, view.frame.width, view.frame.height))
        gifImageView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight;
        view.addSubview(gifImageView)
        
        gifImageView.setAnimatableImage(named: "launching_1.gif")
        // More works is needed here to setup.................
        // gifImageView.setAnimatableImage(data: NSUserDefaultsDataManager.sharedInstance.getLaunchingGIF())
        
        gifImageView.startAnimating()
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(1.5, target: self, selector: Selector("moveToMainViewController"), userInfo: nil, repeats: false)
    }
    
    func moveToMainViewController() {
        gifImageView.stopAnimating()
        
        var mainViewController = MainViewController(nibName:nil, bundle:nil)
        self.navigationController?.pushViewController(mainViewController, animated: true)
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

}
