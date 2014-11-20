//
//  LaunchingViewController.swift
//  Voice
//
//  Created by yiqin on 11/6/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class LaunchingViewController: UIViewController, UIWebViewDelegate {

    lazy var gifImageView:UIImageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        
        gifImageView = UIImageView(frame: CGRectMake(0, 160, 320, 240))
        view.addSubview(gifImageView)
        gifImageView.setAnimatableImage(named: "Launching.gif")
        gifImageView.startAnimating()
        
        var timer = NSTimer.scheduledTimerWithTimeInterval(10, target: self, selector: Selector("moveToMainViewController"), userInfo: nil, repeats: false)
    }
    
    func moveToMainViewController() {
        gifImageView.stopAnimating()
        
        // Testing
        /*
        var mainViewController = MainViewController(nibName:nil, bundle:nil)
        self.navigationController?.pushViewController(mainViewController, animated: false)
        */
        
        var objweb = ArticleHTMLWebView(frame: CGRectMake(0, 0, 320, 560))
        
        objweb.delegate = self
        
        var path = NSBundle.mainBundle().bundlePath
        var baseUrl  = NSURL.fileURLWithPath("\(path)")
        
        self.view.addSubview(objweb)

        
        var query = PFQuery(className:"HTMLTest")
        query.getObjectInBackgroundWithId("Ciu0YsqTfe") { (html: PFObject!, error: NSError!) -> Void in
            if error == nil {
                var htmlPFFile = html.objectForKey("file") as PFFile
                NSLog("%@", htmlPFFile.name)
                
                htmlPFFile.getDataInBackgroundWithBlock({ (htmlData: NSData!, error: NSError!) -> Void in
                    
                    var testData = NSMutableData()
                    testData.appendData(htmlData)
                    testData.appendData(htmlData)
                    
                    var content = NSString(data: testData, encoding: NSUTF8StringEncoding)
                    
                    objweb.loadHTMLString(content, baseURL: baseUrl)
                    
                })
                
            } else {
                NSLog("%@", error)
            }
        }
        
        
        
        /*
        
        // Test webview
        var objweb = ArticleHTMLWebView(frame: CGRectMake(0, 0, 320, 560))
        
        objweb.delegate = self
        var path = NSBundle.mainBundle().bundlePath
        
        var baseUrl  = NSURL.fileURLWithPath("\(path)")
        
        let bundle = NSBundle.mainBundle()
        let pathhtml = bundle.pathForResource("voiceText", ofType: "html")
        var content = String(contentsOfFile:pathhtml!, encoding: NSUTF8StringEncoding, error: nil)

        objweb.loadHTMLString(content, baseURL: baseUrl)
        self.view.addSubview(objweb)
        */
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
