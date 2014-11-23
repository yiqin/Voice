//
//  StreetDetailViewController.swift
//  Voice
//
//  Created by yiqin on 11/20/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class StreetDetailViewController: UIViewController {
    
    /// backButton on the top
    var backButton = YQButtonWithImage(frame: CGRectMake(0, 0, 45, 45), image: "backArrow.png", selectedImage: "backArrow.png")
    
    var streetDetailTVC : StreetDetailBodyTableViewController
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?, article selectedStreetImage: StreetImage? ) {
        
        streetDetailTVC = StreetDetailBodyTableViewController(selectedStreetImage: selectedStreetImage!)
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.view.backgroundColor = UIColor.whiteColor()
        
        streetDetailTVC.view.frame = CGRectMake(0, 45, DeviceManager.sharedInstance.screenWidth, DeviceManager.sharedInstance.screenHeight-45)
        view.addSubview(streetDetailTVC.view)
        
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
