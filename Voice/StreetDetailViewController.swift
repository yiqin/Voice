//
//  StreetDetailViewController.swift
//  Voice
//
//  Created by yiqin on 11/20/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class StreetDetailViewController: UIViewController {
    
    var streetDetailTVC : StreetDetailBodyTableViewController
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?, article selectedStreetImage: StreetImage? ) {
        
        streetDetailTVC = StreetDetailBodyTableViewController(selectedStreetImage: selectedStreetImage!)
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.view.backgroundColor = UIColor.whiteColor()
        
        
        streetDetailTVC.view.frame = CGRectMake(0, 0, DeviceManager.sharedInstance.screenWidth, DeviceManager.sharedInstance.screenHeight)
        // streetDetailTVC.pullToRefreshEnabled = false;
        view.addSubview(streetDetailTVC.view)
        
        
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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backButtonPressed(sender: UIButton!){
        self.navigationController?.popViewControllerAnimated(true)
    }

    func swipeRight(recognizer:UISwipeGestureRecognizer){
        println("Swipe right.")
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
