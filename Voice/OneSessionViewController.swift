//
//  OneMagazineViewController.swift
//  Voice
//
//  Created by Yi Qin on 1/6/15.
//  Copyright (c) 2015 yiqin. All rights reserved.
//

import UIKit

class OneSessionViewController: UIViewController, OneSessionTableViewControllerDelegate {
    
    var pageIndex : Int = 0
    var titleText : String = ""
    var imageFile : String = ""
    
    var oneSessionTVC : OneSessionTableViewController
    var articleDetailViewController : ArticleDetailViewController
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?, session selectedSession: Session? ) {
        
        oneSessionTVC = OneSessionTableViewController(selectedSession: selectedSession!)
        articleDetailViewController = ArticleDetailViewController()
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        // oneSessionTVC.view.frame = CGRectMake(0, 44, DeviceManager.sharedInstance.screenWidth, DeviceManager.sharedInstance.screenHeight-44)
        // oneSessionTVC.view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleWidth
        
        oneSessionTVC.delegate = self
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.whiteColor()
        
        let label = UILabel(frame: CGRectMake(0, 0, view.frame.width, 200))
        label.text = titleText
        label.textAlignment = .Center
        view.addSubview(label)
    }
    
    override func viewWillDisappear(animated: Bool) {
        println("view will disappear.......")
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "PresentArticleDetailViewController", object: nil)
    }
    
    override func viewDidDisappear(animated: Bool) {
        println("view did disappear.......")
        
    }
    
    override func viewDidAppear(animated: Bool) {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "PresentArticleDetailViewController", name: "PresentArticleDetailViewController", object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        oneSessionTVC.view.frame = CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame))
        view.addSubview(oneSessionTVC.view)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        println("view will appear \(pageIndex)")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func moveToSelectStreetImageFromImageRows(selectedStreetImage:StreetImage){
        var streetImageDetailViewController = StreetDetailViewController(nibName: nil, bundle: nil, article: selectedStreetImage)
        
        presentViewController(streetImageDetailViewController, animated: true, completion: { () -> Void in
            
        })
    }
    
    func moveToSelectArticle(selectedArticle:Article) {
        // var articleDetailViewController = ArticleDetailViewController(nibName:nil, bundle:nil, article: selectedArticle)
        articleDetailViewController.selectedArticle = selectedArticle
        articleDetailViewController.loadWeb(selectedArticle)
    }
    
    func PresentArticleDetailViewController(){
        let tempNavigationController = UINavigationController(rootViewController: articleDetailViewController)
        tempNavigationController.setNavigationBarHidden(true, animated: true)
        
        presentViewController(tempNavigationController, animated: true, completion: { () -> Void in
            self.articleDetailViewController.addGuestureRecognizers()
            
        })
    }
    

}
