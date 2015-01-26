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
class ArticleDetailViewController: UIViewController, UIWebViewDelegate, UIGestureRecognizerDelegate {
    
    var selectedArticle : Article
    
    /// The tabla view controller display the detail of the article.
    var articleDetailBodyTVC : ArticleDetailBodyTableViewController
    
    var articleDetailBodyWebView : ArticleDetailBodyWebView
    
    var showBackSubView : Bool = false
    var backSubView : UIView
    let backOffset : CGFloat = 44

    
    override init() {
        self.selectedArticle = Article()
        articleDetailBodyTVC = ArticleDetailBodyTableViewController()
        articleDetailBodyWebView = ArticleDetailBodyWebView()
        backSubView = UIView(frame: CGRectMake(0, -backOffset, DeviceManager.sharedInstance.screenWidth, backOffset))

        super.init(nibName: nil, bundle: nil)
    }
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?, article selectedArticle: Article? ) {
        
        self.selectedArticle = selectedArticle!
        self.articleDetailBodyTVC = ArticleDetailBodyTableViewController(selectedArticle: selectedArticle!)
        
        // articleDetailBodyWebView = ArticleDetailBodyWebView(frame: CGRectMake(0, 0, DeviceManager.sharedInstance.screenWidth, DeviceManager.sharedInstance.screenHeight))
        articleDetailBodyWebView = ArticleDetailBodyWebView()
        
        
        backSubView = UIView(frame: CGRectMake(0, -backOffset, DeviceManager.sharedInstance.screenWidth, backOffset))

        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        view.backgroundColor = UIColor.whiteColor()
        
        
        
        loadWeb()
        
        // Disable articleDetailBodyTVC now.
        articleDetailBodyTVC.view.frame = CGRectMake(0, 0, DeviceManager.sharedInstance.screenWidth, DeviceManager.sharedInstance.screenHeight)
        let randomNumber = Int(arc4random_uniform(2))+2
        self.articleDetailBodyTVC.adPosition = randomNumber;
        // view.addSubview(articleDetailBodyTVC.view)
        
        
        // backSubView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.8)
        backSubView.backgroundColor = UIColor.redColor()
        
        
        var tempBackButton = YQButtonWithImage(frame: CGRectMake(6, 4, 36, 36), image: "back", selectedImage: "back")
        backSubView.addSubview(tempBackButton)
        tempBackButton.addTarget(self, action: "backButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reloadTableViewController", name: "VoiceArticleReload", object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addGuestureRecognizers(){
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "swipeRight:")
        view.addGestureRecognizer(swipeRight)
        println(".....................")
        
        view.userInteractionEnabled = true;
        var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapScreen:")
        tapGestureRecognizer.delegate = self
        view.addGestureRecognizer(tapGestureRecognizer)
        
    }
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        
        println("this delegate")
        
        return true
    }
    
    /**
     After loading the article blocks from Parse.com, we reload article detail.
    */
    func reloadTableViewController() {
        self.articleDetailBodyTVC.tableView.reloadData()
    }
    
    func loadWeb() {
        articleDetailBodyWebView.delegate = self
        // view.addSubview(articleDetailBodyWebView)
        articleDetailBodyWebView.frame = CGRectMake(0, 0, DeviceManager.sharedInstance.screenWidth, DeviceManager.sharedInstance.screenHeight)
        
        articleDetailBodyWebView.loadRequest(NSURLRequest(URL: selectedArticle.urlAddress))
        
        view.backgroundColor = UIColor.redColor()
        view.addSubview(backSubView)
        /*
        println(ArticleDetailManager.sharedInstance.checkWhetherDataAreReady())
        // Why selectedArticle has zero values...
        if (selectedArticle.isArticleBlocksReady){
            
            var path = NSBundle.mainBundle().bundlePath
            var baseUrl  = NSURL.fileURLWithPath("\(path)")
            
            var allHtmlData = NSMutableData()
            
            for articleBlock in selectedArticle.articleBlocks {
                allHtmlData.appendData((articleBlock as ArticleBlock).htmlData)
            }
            var content = NSString(data: allHtmlData, encoding: NSUTF8StringEncoding)
            articleDetailBodyWebView.loadHTMLString(content, baseURL: baseUrl)
            
        }
        else if(ArticleDetailManager.sharedInstance.checkWhetherDataAreReady()){
            
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
            var timer = NSTimer.scheduledTimerWithTimeInterval(0.05, target: self, selector: Selector("loadWeb"), userInfo: nil, repeats: false)
        }
        */
        
    }
    
    
    func webViewDidStartLoad(webView: UIWebView) {
        SVProgressHUD.show()
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        // More animations come here.
        // view.addSubview(articleDetailBodyWebView)
        
        SVProgressHUD.dismiss()
        
        NSNotificationCenter.defaultCenter().postNotificationName("PresentArticleDetailViewController", object: nil, userInfo: nil)
        
        // self.view.insertSubview(self.articleDetailBodyWebView, belowSubview: self.backButton)
        
        
        /*
        UIView.transitionWithView(view, duration: 0.5, options: UIViewAnimationOptions.TransitionCrossDissolve, animations: { () -> Void in
            
        }) { (completion) -> Void in
            
        }
        */
    }
    
    func backButtonPressed(sender: UIButton!){
        // self.navigationController?.popViewControllerAnimated(true)
        dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    func tapScreen(recognizer:UITapGestureRecognizer){
        println("Tap... .")
        checkBackSubView()
    }
    
    func checkBackSubView(){
        if (showBackSubView){
            UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseOut, animations: { () -> Void in
                self.backSubView.frame = CGRectMake(0, -self.backOffset, DeviceManager.sharedInstance.screenWidth, self.backOffset)
                println("we are going to close it.")
                
                }, completion: { (finish) -> Void in
                    self.showBackSubView = false
            })
            
        }
        else {
            // let currentWindow = UIApplication.sharedApplication().keyWindow
            println(self.backSubView.frame.origin.x)
            println(self.backSubView.frame.origin.y)

            println(self.backSubView.frame.width)
            println(self.backSubView.frame.height)
            // view.addSubview()
            UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseOut, animations: { () -> Void in
                self.backSubView.frame = CGRectMake(0, 0, DeviceManager.sharedInstance.screenWidth, self.backOffset)
                
                println("Do u see the view?")
                
                }, completion: { (finish) -> Void in
                    self.showBackSubView = true
            })
        }
    }
    
    func swipeRight(recognizer:UISwipeGestureRecognizer){
        println("Swipe right.")
        popBackToMainViewController()
    }
    
    func popBackToMainViewController(){
        SVProgressHUD.popActivity()
        SVProgressHUD.dismiss()
        
        // self.navigationController?.popViewControllerAnimated(true)
        dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
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
