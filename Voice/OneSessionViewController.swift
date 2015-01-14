//
//  OneMagazineViewController.swift
//  Voice
//
//  Created by Yi Qin on 1/6/15.
//  Copyright (c) 2015 yiqin. All rights reserved.
//

import UIKit

class OneSessionViewController: UIViewController {
    
    var pageIndex : Int = 0
    var titleText : String = ""
    var imageFile : String = ""
    
    var oneSessionTVC : OneSessionTableViewController
    
    init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?, session selectedSession: Session? ) {
        
        oneSessionTVC = OneSessionTableViewController(session: selectedSession!)
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        view.addSubview(oneSessionTVC.view)
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
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        println("view will appear \(pageIndex)")
        
    }
    
    
    
    
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
    
    
    

}
