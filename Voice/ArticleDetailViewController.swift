//
//  ArticleDetailViewController.swift
//  Voice
//
//  Created by yiqin on 10/27/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class ArticleDetailViewController: UIViewController {
    
    var backButton = UIButton()
    var articleDetailBodyTVC = ArticleDetailBodyTableViewController()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.view.backgroundColor = UIColor.whiteColor()
        backButton.frame = CGRectMake(0, 30, 100, 30)
        backButton.backgroundColor = UIColor.redColor()
        backButton.addTarget(self, action: "backButtonPressed:", forControlEvents: .TouchUpInside)
        view.addSubview(backButton)
        
        articleDetailBodyTVC.view.frame = CGRectMake(0, 60, DeviceManager.sharedInstance.screenWidth, DeviceManager.sharedInstance.screenHeight-60)
        view.addSubview(articleDetailBodyTVC.view)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        // Do any additional setup after loading the view.
    }
    
    func backButtonPressed(sender: UIButton!){
        self.navigationController?.popViewControllerAnimated(true)
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
