//
//  OneSectionTableViewController.swift
//  Voice
//
//  Created by Yi Qin on 1/13/15.
//  Copyright (c) 2015 yiqin. All rights reserved.
//

import UIKit

class OneSessionTableViewController: UITableViewController {
    
    init(session: Session) {
        super.init(nibName: nil, bundle: nil)    // this has a higher priority.
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.grayColor()
        tableView.separatorColor = UIColor.clearColor()
    }
    
    

}
