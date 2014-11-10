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
    
    var selectedArticle : Article
    
    /// backButton on the top
    var backButton = YQButtonWithImage(frame: CGRectMake(0, 0, 45, 45), image: "backArrow.png", selectedImage: "backArrow.png")
    
    /// The tabla view controller display the detail of the article.
    var articleDetailBodyTVC : ArticleDetailBodyTableViewController
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?, article selectedArticle: Article? ) {
        
        self.selectedArticle = selectedArticle!
        self.articleDetailBodyTVC = ArticleDetailBodyTableViewController(selectedArticle: selectedArticle!)
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.view.backgroundColor = UIColor.whiteColor()
        
        articleDetailBodyTVC.view.frame = CGRectMake(0, 0, DeviceManager.sharedInstance.screenWidth, DeviceManager.sharedInstance.screenHeight)
        let randomNumber = Int(arc4random_uniform(2))+2
        self.articleDetailBodyTVC.adPosition = randomNumber;
        view.addSubview(articleDetailBodyTVC.view)
        
        backButton.addTarget(self, action: "backButtonPressed:", forControlEvents: .TouchUpInside)
        view.addSubview(backButton)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTableViewController", name: "VoiceArticleReload", object: nil)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        Leaftagger.tagLeafOnViewController(self)
    }
    
    func backButtonPressed(sender: UIButton!){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
     After loading the article blocks from Parse.com, we reload article detail.
    */
    func reloadTableViewController() {
        self.articleDetailBodyTVC.tableView.reloadData()
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
