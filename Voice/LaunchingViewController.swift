//
//  LaunchingViewController.swift
//  Voice
//
//  Created by yiqin on 11/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class LaunchingViewController: UIViewController {

    lazy var gifImageView:UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        gifImageView = UIImageView(frame: CGRectMake(0, 160, 320, 240))
        view.addSubview(gifImageView)
        gifImageView.setAnimatableImage(named: "Launching.gif")
        gifImageView.startAnimating()
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: Selector("moveToMainViewController"), userInfo: nil, repeats: false)
    }
    
    func moveToMainViewController() {
        gifImageView.stopAnimating()
        var mainViewController = MainViewController(nibName:nil, bundle:nil)
        self.navigationController?.pushViewController(mainViewController, animated: false)
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
