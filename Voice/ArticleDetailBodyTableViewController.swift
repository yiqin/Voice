//
//  ArticleDetailBodyTableViewController.swift
//  Voice
//
//  Created by yiqin on 10/27/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class ArticleDetailBodyTableViewController: UITableViewController {

    var adPosition = -1 // Default value
    var blockIndex = 0  // A pointer.
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.grayColor()
        tableView.separatorColor = UIColor.clearColor()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        
        if(ArticleDetailManager.sharedInstance.articleBlocks.count==0){
            return 1;
        }
        else {
            return ArticleDetailManager.sharedInstance.articleBlocks.count+2;
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return ArticleCoverTableViewCell.cellHeight()
        }
        else if (indexPath.row == adPosition) {
            return AdTableViewCell.cellHeight()
        }
        else {
            return ArticleTextBlockTableViewCell.cellHeight()
        }
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let articleCoverIdentifier = "ArticleCoverIdentifier"
        let articleTextBlockIdentifier = "ArticleTextBlockIdentifier"
        let adIdentifier = "AdIdentifier"
        
        if (indexPath.row == 0){
            var cell = tableView.dequeueReusableCellWithIdentifier(articleCoverIdentifier) as? ArticleCoverTableViewCell
            
            if cell != nil {
                // println("Cell exist")
                
            }
            else {
                // println("Create new Cell")
                cell = ArticleCoverTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: articleCoverIdentifier)
            }
            cell?.textLabel.text = "Cover Page"
            return cell!
        }
        else if (indexPath.row == adPosition){
            var cell = tableView.dequeueReusableCellWithIdentifier(adIdentifier) as? AdTableViewCell
            
            if cell != nil {
                // println("Cell exist")
                
            }
            else {
                // println("Create new Cell")
                cell = AdTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: adIdentifier)
            }

            cell?.textLabel.text = "Ad"
            return cell!
        }
        else {
            var cell = tableView.dequeueReusableCellWithIdentifier(articleTextBlockIdentifier) as? ArticleTextBlockTableViewCell
            
            if cell != nil {
                // println("Cell exist")
            }
            else {
                // println("Create new Cell")
                cell = ArticleTextBlockTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: articleTextBlockIdentifier)
            }
            

            cell?.textLabel.text = "Article Text"
            
            if (indexPath.row < adPosition && indexPath.row > 0){
                blockIndex = indexPath.row-1
            }
            else if (indexPath.row > adPosition){
                blockIndex = indexPath.row-2
            }
            
            if(blockIndex <= ArticleDetailManager.sharedInstance.articleBlocks.count-1){
                let articleBlock = ArticleDetailManager.sharedInstance.articleBlocks.objectAtIndex(blockIndex) as ArticleBlock
                cell?.textLabel.text = articleBlock.text
            }
            cell?.textLabel.numberOfLines = 0
            
            return cell!
        }
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Select \(indexPath.row)")
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
    }
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
