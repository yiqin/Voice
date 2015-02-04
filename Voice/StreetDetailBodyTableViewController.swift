//
//  StreetDetailBodyTableViewController.swift
//  Voice
//
//  Created by yiqin on 11/20/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class StreetDetailBodyTableViewController: UITableViewController, UITableViewDelegate {
    
    var streetImage: StreetImage
    
    /// Check is it the first time to load the image from parse.com?
    var isFisrtLoadCheckSet: NSMutableSet
    /// Store images from parse.com and fetch images locally
    var imageDictionary: NSMutableDictionary
    var imageHeightDictionary : NSMutableDictionary
    
    var objects : NSArray
    var streetDetailImages : NSMutableArray
    
    init(selectedStreetImage: StreetImage) {
        streetImage = selectedStreetImage
        isFisrtLoadCheckSet = NSMutableSet()
        imageDictionary = NSMutableDictionary()
        imageHeightDictionary = NSMutableDictionary()
        objects = NSArray()
        streetDetailImages = NSMutableArray()
        
        super.init(nibName: nil, bundle: nil)    // this has a higher priority.
        
        self.tableView.separatorColor = UIColor.clearColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        startLoadDataFromParse()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startLoadDataFromParse() {
        var query = PFQuery(className: "StreetDetailImage")
        query.whereKey("belongTo", equalTo: streetImage.parseObject)
        query.orderByAscending("indexNumber")
        
        SVProgressHUD.show()
        query.findObjectsInBackgroundWithBlock { (objects:[AnyObject]!, error:NSError!) -> Void in
            
            SVProgressHUD.dismiss()
            
            
            self.objects = objects
            
            
            
            for var i = 0; i < objects.count; i++ {
                let object = objects[i] as PFObject
                self.streetDetailImages.addObject(StreetDetailImage(parseObject: object))
                
                if(i == objects.count-1){
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    /// Update height here after the downlaod is finished.
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if(indexPath.row == -1){
            let image = streetImage.uiimage
            let ratio = DeviceManager.sharedInstance.screenWidth/image.size.width
            return image.size.height*ratio
        }
        else {
            let streetDetailImage = streetDetailImages[indexPath.row] as StreetDetailImage
            return streetDetailImage.imageCellHeight
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let streetDetailImageTableIdentifier = "StreetDetailImageTableIdentifier"
        
        let object = objects[indexPath.row] as PFObject
        let streetDetailImage = streetDetailImages[indexPath.row] as StreetDetailImage
        
        var cell = tableView.dequeueReusableCellWithIdentifier(streetDetailImageTableIdentifier) as? StreetDetailBlockTableViewCell
        
        if(cell == nil){
            cell = StreetDetailBlockTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: streetDetailImageTableIdentifier)
            cell?.selectionStyle = UITableViewCellSelectionStyle.None
            println("create table view cell.")
        }
        
        if(indexPath.row == -1){
            cell?.streetDetailImageView.image = streetImage.uiimage
        }
        else {
            if (streetDetailImage.isImageLoading){
                let thunmbnail = object["image"] as PFFile
                cell?.streetDetailImageView.file = thunmbnail
                // cell?.streetDetailImageView.image = UIImage(named: "defaultImage.png")
                
                cell?.streetDetailImageView.loadInBackground { (image:UIImage!, error: NSError!) -> Void in
                    
                }
            }
            else {
                println("load locally.")
                cell?.streetDetailImageView.image = streetDetailImage.image
            }
        }
        
        return cell!
    }
}
