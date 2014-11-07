//
//  LaunchingViewController.swift
//  Voice
//
//  Created by yiqin on 11/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class LaunchingViewController: UIViewController {

    lazy var imageView:YLImageView = YLImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.frame = CGRectMake(10, 50, 300, 240)
        self.view.addSubview(self.imageView)
        let path = NSBundle.mainBundle().URLForResource("joy", withExtension: "gif")
        let data = NSData(contentsOfURL: path!)
        self.imageView.image = YLGIFImage(data: data!)
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: Selector("moveToMainViewController"), userInfo: nil, repeats: false)
    }
    
    func moveToMainViewController() {
        var mainViewController = MainViewController(nibName:nil, bundle:nil)
        // articleDetailViewController.selectedArticle = selectedArticle;
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
