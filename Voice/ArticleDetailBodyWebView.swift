//
//  ArticleDetailBodyWebView.swift
//  Voice
//
//  Created by yiqin on 11/23/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class ArticleDetailBodyWebView: UIWebView {
    
    var path = NSBundle.mainBundle().bundlePath
    var baseUrl = NSURL()
    
    var allHtmlData = NSMutableData()
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        var baseUrl  = NSURL.fileURLWithPath("\(path)")
        
        
         var timer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("load"), userInfo: nil, repeats: false)
        
    }
    
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func load(){
        println(ArticleDetailManager.sharedInstance.checkWhetherDataAreReady())
        
        if(ArticleDetailManager.sharedInstance.checkWhetherDataAreReady()){
            
            for articleBlock in ArticleDetailManager.sharedInstance.articleBlocks {
                allHtmlData.appendData((articleBlock as ArticleBlock).htmlData)
            }
            var content = NSString(data: allHtmlData, encoding: NSUTF8StringEncoding)
            loadHTMLString(content, baseURL: baseUrl)
            
            SVProgressHUD.dismiss()
        }
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
