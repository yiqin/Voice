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
    
    var showBackSubView : Bool = false
    var backSubView : UIView
    let backOffset : CGFloat = 44
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?, article selectedStreetImage: StreetImage? ) {
        
        streetDetailTVC = StreetDetailBodyTableViewController(selectedStreetImage: selectedStreetImage!)
        backSubView = UIView(frame: CGRectMake(0, -backOffset, DeviceManager.sharedInstance.screenWidth, backOffset))
        
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.view.backgroundColor = UIColor.whiteColor()
        
        
        streetDetailTVC.view.frame = CGRectMake(0, 0, DeviceManager.sharedInstance.screenWidth, DeviceManager.sharedInstance.screenHeight)
        // streetDetailTVC.pullToRefreshEnabled = false;
        view.addSubview(streetDetailTVC.view)
        
        
        backSubView.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.8)
        
        
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
        
        var swipeRight = UISwipeGestureRecognizer(target: self, action: "swipeRight:")
        view.addGestureRecognizer(swipeRight)
        
        var tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "tapScreen:")
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func backButtonPressed(sender: UIButton!){
        // self.navigationController?.popViewControllerAnimated(true)
        dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }

    func swipeRight(recognizer:UISwipeGestureRecognizer){
        println("Swipe right.")
        // self.navigationController?.popViewControllerAnimated(true)
        dismissViewControllerAnimated(true, completion: { () -> Void in
            
        })
    }
    
    func tapScreen(recognizer:UISwipeGestureRecognizer){
        println("Tap... .")
        
        // showBackSubView = true
        checkBackSubView()
    }
    
    func checkBackSubView(){
        if (showBackSubView){
            UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseOut, animations: { () -> Void in
                self.backSubView.frame = CGRectMake(0, -self.backOffset, DeviceManager.sharedInstance.screenWidth, self.backOffset)
                
                }, completion: { (finish) -> Void in
                    self.showBackSubView = false
            })
            
        }
        else {
            view.addSubview(backSubView)
            UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseOut, animations: { () -> Void in
                self.backSubView.frame = CGRectMake(0, 0, DeviceManager.sharedInstance.screenWidth, self.backOffset)
                
                }, completion: { (finish) -> Void in
                    self.showBackSubView = true
            })
        }
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
