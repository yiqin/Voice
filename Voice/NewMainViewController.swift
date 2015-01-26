//
//  NewMainViewController.swift
//  Voice
//
//  Created by Yi Qin on 1/6/15.
//  Copyright (c) 2015 yiqin. All rights reserved.
//

import UIKit

class NewMainViewController: UIViewController, UIPageViewControllerDataSource {
    
    var pageViewController : UIPageViewController?
    var currentIndex : Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "V O I C E"
        
        /*
        NSMutableAttributedString *text =
            [[NSMutableAttributedString alloc]
                initWithAttributedString: label.attributedText];
        
        [text addAttribute:NSForegroundColorAttributeName
            value:[UIColor redColor]
            range:NSMakeRange(10, 1)];
        [label setAttributedText: text];
        */
        let tempString = "V O I C E"
        // var tempText = NSMutableAttributedString(string: tempString)
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        navigationController?.navigationBar.titleTextAttributes = titleDict
        
        
        view.backgroundColor = UIColor.whiteColor()
        
        pageViewController = UIPageViewController(transitionStyle: .Scroll, navigationOrientation: .Horizontal, options: nil)
        pageViewController!.dataSource = self
        
        let startingViewController: OneSessionViewController = viewControllerAtIndex(0)!
        let viewControllers: NSArray = [startingViewController]
        pageViewController!.setViewControllers(viewControllers, direction: .Forward, animated: false, completion: nil)
        
        
        let tempOffset:CGFloat = 20
        pageViewController!.view.frame = CGRectMake(0, tempOffset, DeviceManager.sharedInstance.screenWidth, DeviceManager.sharedInstance.screenHeight-tempOffset)
        // pageViewController!.view.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleWidth
        
        addChildViewController(pageViewController!)
        view.addSubview(pageViewController!.view)
        pageViewController!.didMoveToParentViewController(self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
        var index = (viewController as OneSessionViewController).pageIndex
        
        if (index == 0) || (index == NSNotFound) {
            return nil
        }
        
        index--
        
        return viewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
    {
        var index = (viewController as OneSessionViewController).pageIndex
        
        if index == NSNotFound {
            return nil
        }
        
        index++
        
        if (index == SessionsManager.sharedInstance.sessions.count) {
            return nil
        }
        
        return viewControllerAtIndex(index)
    }
    
    func viewControllerAtIndex(index: Int) -> OneSessionViewController?
    {
        if SessionsManager.sharedInstance.sessions.count == 0 || index >= SessionsManager.sharedInstance.sessions.count
        {
            return nil
        }
        
        // Create a new view controller and pass suitable data.
        // Every time we create a new OneSessionViewController. This is wrong. ....
        let session = SessionsManager.sharedInstance.sessions[index] as Session
        let pageContentViewController = OneSessionViewController(nibName: nil, bundle: nil, session: session)
        
        // pageContentViewController.imageFile = pageImages[index]
        // pageContentViewController.titleText = pageTitles[index]
        
        pageContentViewController.pageIndex = index
        currentIndex = index
        
        println(index)
        
        return pageContentViewController
    }
    
    
    
    
}

