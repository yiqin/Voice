//
//  ArticleDetailViewController.swift
//  Voice
//
//  Created by yiqin on 10/27/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

/**
 Display the detail of an article. 
 The detail consist of several blcoks, including the over page, text paragraghes and images
*/
class ArticleDetailViewController: UIViewController {
    
    /// backButton on the top
    var backButton = YQButtonWithImage(frame: CGRectMake(0, 0, 45, 45), image: "backArrow.png", selectedImage: "backArrow.png")
    
    /// The tabla view controller display the detail of the article.
    var articleDetailBodyTVC = ArticleDetailBodyTableViewController()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.view.backgroundColor = UIColor.whiteColor()
        
        articleDetailBodyTVC.view.frame = CGRectMake(0, 60, DeviceManager.sharedInstance.screenWidth, DeviceManager.sharedInstance.screenHeight-60)
        
        
        // So-called A&B Testing
        // If the test is not reset, A/B testing won't change.
        SkyLab.abTestWithName("SLAdPosition", a: { () -> Void in
            println("SLAdPosition: a test")
            self.articleDetailBodyTVC.adPosition = 2;
        
        }, b: { () -> Void in
            println("SLAdPosition: b test")
            self.articleDetailBodyTVC.adPosition = 3;
        })
        SkyLab.resetTestNamed("SLAdPosition")
        
        
        view.addSubview(articleDetailBodyTVC.view)
        
        
        backButton.addTarget(self, action: "backButtonPressed:", forControlEvents: .TouchUpInside)
        view.addSubview(backButton)
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
