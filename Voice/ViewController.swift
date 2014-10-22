//
//  ViewController.swift
//  Voice
//
//  Created by yiqin on 10/17/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit
import Parse

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var testObject = PFObject(className: "VoiceObject")
        testObject["foo"] = "good"
        testObject.saveInBackgroundWithBlock { (success:Bool!, error:NSError!) -> Void in
            if success != nil {
                println("Save Parse data successfully.")
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

