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
        self.view.hidden = false;
        
        pullToRefreshEnabled = false;
        paginationEnabled = false;
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
        
        if (self.pullToRefreshEnabled) {
            query.cachePolicy = kPFCachePolicyNetworkOnly;
        }
        
        /*
        if(self.objects.count == 0){
            query.cachePolicy = kPFCachePolicyCacheThenNetwork
        }
        */
        
        return query
    }
    
    override func objectsDidLoad(error: NSError!) {
        super.objectsDidLoad(error) // Don't forget the super method.
    }
    
    /// Update height here after the downlaod is finished.
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let object = self.objects[indexPath.row] as PFObject
        let cellHeight = object["imageHeight"] as NSNumber
        
        return CGFloat(cellHeight)
    }
    
    override func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!, object: PFObject!) -> PFTableViewCell! {
        let streetDetailImageTableIdentifier = "StreetDetailImageTableIdentifier"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(streetDetailImageTableIdentifier) as? StreetDetailBlockTableViewCell
        
        if(cell == nil){
            cell = StreetDetailBlockTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: streetDetailImageTableIdentifier)
        }
        cell?.selectionStyle = UITableViewCellSelectionStyle.None
        
        
        if ((isFisrtLoadCheckSet.member(indexPath.row)) == nil){
            
            let thunmbnail = object["image"] as PFFile
            cell?.streetDetailImageView.file = thunmbnail
            cell?.streetDetailImageView.image = UIImage(named: "defaultImage.png")
            
            cell?.streetDetailImageView.loadInBackground { (image:UIImage!, error: NSError!) -> Void in
                
                println("Load Street Detail Image ssauccesfully.")
                
                println("Image Width: \(image.size.width)")
                println("Image Height: \(image.size.height)")
                
                let ratio = DeviceManager.sharedInstance.screenWidth/image.size.width
                
                
                var object_ = self.objects[indexPath.row] as PFObject
                
                object_.setObject(NSNumber(float: Float(image.size.height*ratio)), forKey: "imageHeight")
                println(image.size.height*ratio)
                
                self.imageDictionary.setObject(image, forKey: indexPath.row)
                
                tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Fade)
                
               self.isFisrtLoadCheckSet.addObject(indexPath.row)
            }
        }
        else {
            // let thunmbnail = object["image"] as PFFile
            // cell?.streetDetailImageView.file = thunmbnail
            cell?.streetDetailImageView.image = (imageDictionary.objectForKey(indexPath.row) as? UIImage)
        }
        
        
        return cell
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
