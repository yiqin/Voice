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
class ArticleDetailViewController: UIViewController, UIWebViewDelegate {
    
    var selectedArticle : Article
    
    /// backButton on the top
    var backButton = YQButtonWithImage(frame: CGRectMake(0, 0, 45, 45), image: "backArrow.png", selectedImage: "backArrow.png")
    
    /// The tabla view controller display the detail of the article.
    var articleDetailBodyTVC : ArticleDetailBodyTableViewController
    
    var articleDetailBodyWebView : ArticleDetailBodyWebView
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?, article selectedArticle: Article? ) {
        
        self.selectedArticle = selectedArticle!
        self.articleDetailBodyTVC = ArticleDetailBodyTableViewController(selectedArticle: selectedArticle!)
        
        articleDetailBodyWebView = ArticleDetailBodyWebView(frame: CGRectMake(0, 45, DeviceManager.sharedInstance.screenWidth, DeviceManager.sharedInstance.screenHeight-45))
        
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.view.backgroundColor = UIColor.whiteColor()
        
        articleDetailBodyWebView.delegate = self
        
        load()
        
        // Disable articleDetailBodyTVC now.
        articleDetailBodyTVC.view.frame = CGRectMake(0, 0, DeviceManager.sharedInstance.screenWidth, DeviceManager.sharedInstance.screenHeight)
        let randomNumber = Int(arc4random_uniform(2))+2
        self.articleDetailBodyTVC.adPosition = randomNumber;
        // view.addSubview(articleDetailBodyTVC.view)
        
        
        backButton.addTarget(self, action: "backButtonPressed:", forControlEvents: .TouchUpInside)
        view.addSubview(backButton)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTableViewController", name: "VoiceArticleReload", object: nil)
        
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "swipeRight:")
        self.view.addGestureRecognizer(swipeRight)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
                
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
        SVProgressHUD.show()

    }

    
    func backButtonPressed(sender: UIButton!){
        popBackToMainViewController()
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
    
    
    func load(){
        println(ArticleDetailManager.sharedInstance.checkWhetherDataAreReady())
        
        if(ArticleDetailManager.sharedInstance.checkWhetherDataAreReady()){
            
            var path = NSBundle.mainBundle().bundlePath
            var baseUrl  = NSURL.fileURLWithPath("\(path)")
            
            var allHtmlData = NSMutableData()
            
            for articleBlock in ArticleDetailManager.sharedInstance.articleBlocks {
                allHtmlData.appendData((articleBlock as ArticleBlock).htmlData)
            }
            var content = NSString(data: allHtmlData, encoding: NSUTF8StringEncoding)
            articleDetailBodyWebView.loadHTMLString(content, baseURL: baseUrl)
            
        }
        else {
            // this is not a perfect method.
            var timer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: Selector("load"), userInfo: nil, repeats: false)
        }
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        // More animations come here.
        // view.addSubview(articleDetailBodyWebView)
        
        SVProgressHUD.popActivity()
        SVProgressHUD.dismiss()
        
        UIView.transitionWithView(view, duration: 0.5, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
            self.view.insertSubview(self.articleDetailBodyWebView, belowSubview: self.backButton)
        }) { (completion) -> Void in
            
        }
    }
    
    func swipeRight(recognizer:UISwipeGestureRecognizer){
        println("Swipe right.")
        popBackToMainViewController()
    }
    
    func popBackToMainViewController(){
        SVProgressHUD.popActivity()
        SVProgressHUD.dismiss()
        self.navigationController?.popViewControllerAnimated(true)
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
