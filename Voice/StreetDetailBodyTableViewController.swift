//
//  StreetDetailBodyTableViewController.swift
//  Voice
//
//  Created by yiqin on 11/20/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class StreetDetailBodyTableViewController: PFQueryTableViewController, UITableViewDelegate {
    
    var streetImage: StreetImage
    
    /// Check is it the first time to load the image from parse.com?
    var isFisrtLoadCheckSet: NSMutableSet
    /// Store images from parse.com and fetch images locally
    var imageDictionary: NSMutableDictionary
    
    init(selectedStreetImage: StreetImage) {
        streetImage = selectedStreetImage
        isFisrtLoadCheckSet = NSMutableSet()
        imageDictionary = NSMutableDictionary()
        
        super.init(nibName: nil, bundle: nil)    // this has a higher priority.
        self.tableView.separatorColor = UIColor.clearColor()
        // self.view.hidden = false;
        
        pullToRefreshEnabled = false;
        self.refreshControl = nil;   // Disable refresh......
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func queryForTable() -> PFQuery! {
        var query = PFQuery(className: "StreetDetailImage")
        query.whereKey("belongTo", equalTo: streetImage.parseObject)
        query.orderByAscending("indexNumber")
        
        return query
    }
    
    override func objectsDidLoad(error: NSError!) {
        super.objectsDidLoad(error) // Don't forget the super method.
        
        
        //**********************************************//
        //  A Bug here.........
        //**********************************************//
        for var i = 0; i < objects.count; i++ {
            let object = objects[i] as PFObject
            let thunmbnail = object["image"] as PFFile
            var tempImageView = PFImageView()
            tempImageView.file = thunmbnail
            // cell?.streetDetailImageView.image = UIImage(named: "defaultImage.png")
            tempImageView.loadInBackground { (image:UIImage!, error: NSError!) -> Void in
                
                println("here \(i)")
                
                self.imageDictionary.setObject(image, forKey: i)
                self.isFisrtLoadCheckSet.addObject(i)
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
            let object = objects[indexPath.row] as PFObject
            // let cellHeight = object["imageHeight"] as NSNumber // this will be updated later........ #important.
            
            let ratio = object["ratio"] as NSNumber
            
            let cellHeight = DeviceManager.sharedInstance.screenWidth/CGFloat(ratio.floatValue)
            return CGFloat(cellHeight)
        }
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!, object: PFObject!) -> PFTableViewCell! {
        let streetDetailImageTableIdentifier = "StreetDetailImageTableIdentifier"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(streetDetailImageTableIdentifier) as? StreetDetailBlockTableViewCell
        
        if(cell == nil){
            cell = StreetDetailBlockTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: streetDetailImageTableIdentifier)
        }
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        
        if(indexPath.row == -1){
            cell?.streetDetailImageView.image = streetImage.uiimage
        }
        else {
            if ((isFisrtLoadCheckSet.member(indexPath.row)) == nil){
                
                let thunmbnail = object["image"] as PFFile
                cell?.streetDetailImageView.file = thunmbnail
                // cell?.streetDetailImageView.image = UIImage(named: "defaultImage.png")
                
                println("Load Street Detail Image ssauccesfully.")
                
                cell?.streetDetailImageView.loadInBackground { (image:UIImage!, error: NSError!) -> Void in
                    self.imageDictionary.setObject(image, forKey: indexPath.row)
                    self.isFisrtLoadCheckSet.addObject(indexPath.row)
                }
            }
            else {
                println("load locally.")
                cell?.streetDetailImageView.image = (imageDictionary.objectForKey(indexPath.row) as? UIImage)
            }
        }
        
        return cell
    }
}
