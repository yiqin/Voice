//
//  News.swift
//  Voice
//
//  Created by yiqin on 10/22/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class Article: NSVoiceObject {
    
    var title: String
    // var briefDescription: String
    
    var urlAddress : NSURL
    
    var briefImage: PFImageView
    var briefImagePFFile: PFFile
    var isbriefImageLoading:Bool
    
    var effectedImage : UIImage
    
    // No use
    var articleBlocks : NSMutableArray = []
    var isArticleBlocksReady = false
    
    
    var alreadyLike : Bool
    var isLoadingAlreadyLike : Bool
    
    
    override init() {
        title = ""
        urlAddress = NSURL()
        briefImage = PFImageView()
        briefImagePFFile = PFFile()
        isbriefImageLoading = true
        effectedImage = UIImage()
        
        alreadyLike = false
        isLoadingAlreadyLike = true
        
        super.init()
    }
    
    override init(parseObject:PFObject) {
        isbriefImageLoading = true
        
        title = parseObject["title"] as String
        // briefDescription = parseObject["briefDescription"] as String    // How to check this value
        
        // let tempURLString = parseObject["url"] as String
        let tempURLString = "http://voice.parseapp.com/preview/article/"+parseObject.objectId
        urlAddress = NSURL(string: tempURLString)!
        
        briefImagePFFile = parseObject["briefImage"] as PFFile
        
        
        briefImage = PFImageView()
        briefImage.file = briefImagePFFile
        
        effectedImage = UIImage()
        
        alreadyLike = false
        isLoadingAlreadyLike = true
        
        
        
        super.init(parseObject:parseObject)
        
        briefImage.loadInBackground { (image:UIImage!, error: NSError!) -> Void in
            println("Load article image succesfully.")
            
            let tempImage = image
            let tempImageWidth = tempImage?.size.width
            let tempImageHeight = tempImage?.size.height
            let ratio = DeviceManager.sharedInstance.screenWidth/tempImageWidth!
            
            let scaledTempImage = tempImage?.scaleToSize(CGSizeMake(DeviceManager.sharedInstance.screenWidth, tempImageHeight!*ratio))
            let croppedTempImage = scaledTempImage?.cropToSize(CGSizeMake(DeviceManager.sharedInstance.screenWidth, 150), usingMode: NYXCropModeCenter)
            let blurTempImage = croppedTempImage?.gaussianBlurWithBias(0)
            
            let blurTempImage2 = blurTempImage?.opacity(0.9)
            
            // self.effectedImage = blurTempImage2!
            self.effectedImage = croppedTempImage!
            self.isbriefImageLoading = false
        }
        
        
        if let tempUser = PFUser.currentUser() {
            var query = PFQuery(className: "LikeArticle")
            query.whereKey("user", equalTo: PFUser.currentUser())
            query.whereKey("article", equalTo: parseObject)
            query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error:NSError!) -> Void in
                if((error) == nil){
                    self.isLoadingAlreadyLike = false
                    if(objects.count > 0){
                        self.alreadyLike = true
                    }
                    else {
                        self.alreadyLike = false
                    }
                }
                else {
                    
                }
            }
        } else {
            self.isLoadingAlreadyLike = false
            self.alreadyLike = false
        }
        
        
        
        // We don't load the whole article before we click it.
        // directlyLoadWholeArticleWithNotification(false)
    }
    
    //############### Never Call ###############//
    /// load html file of the article
    func directlyLoadWholeArticleWithNotification(sendNotification: Bool){
        var query  = PFQuery(className: "ArticleBlock")
        query.orderByAscending("indexNumber")
        query.whereKey("belongTo", equalTo: self.parseObject)
        
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                var recievedObjects = NSMutableArray()
                
                /*****************************/
                // This is not a safe method.
                // Only one object is returned.
                for object in objects {
                    let newReadyObject = ArticleBlock(parseObject: object as PFObject)
                    // println(newReadyObject.text)
                    
                    if sendNotification {
                        // Add it to ArticleDetailManager
                        ArticleDetailManager.sharedInstance.addArticleBlock(newReadyObject)
                    }
                    
                    recievedObjects.addObject(newReadyObject)
                }
                
                // Send a notification to tableViewControlle to relaod the data.
                if sendNotification {
                    ArticleDetailManager.sharedInstance.removeArticleBlocks()
                    NSNotificationCenter.defaultCenter().postNotificationName("VoiceArticleReload", object: nil)
                }
                
                
                self.articleBlocks.removeAllObjects()
                self.articleBlocks.addObjectsFromArray(recievedObjects)
                
                self.isArticleBlocksReady = true
                self.testHTML()
            } else {
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }
    
    // Need to check this method....
    // It seems this method is reduntand. I'm not sure right now.
    func startLoadWholeArticle(){
        // remove articleblocks no mater what it has.
        // Maybe not
        
        // If articleBlocks already have contents, directly return. No need to load again.
        if (articleBlocks.count>0){
            ArticleDetailManager.sharedInstance.addAllArticleBlcoks(articleBlocks)
            return
        }
        
        directlyLoadWholeArticleWithNotification(true)
    }
    
    
    func testHTML(){
        // Assign a value here.
        var articleDetailBodyWebView = ArticleDetailBodyWebView(frame: CGRectMake(0, 0, 320, 560))
        
        var path = NSBundle.mainBundle().bundlePath
        var baseUrl  = NSURL.fileURLWithPath("\(path)")
        
        var allHtmlData = NSMutableData()
        
        for articleBlock in articleBlocks {
            allHtmlData.appendData((articleBlock as ArticleBlock).htmlData)
        }
        var content = NSString(data: allHtmlData, encoding: NSUTF8StringEncoding)
        articleDetailBodyWebView.loadHTMLString(content, baseURL: baseUrl)
    }
}
