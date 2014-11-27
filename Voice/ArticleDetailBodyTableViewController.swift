//
//  ArticleDetailBodyTableViewController.swift
//  Voice
//
//  Created by yiqin on 10/27/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

class ArticleDetailBodyTableViewController: UITableViewController {

    /// Ad position in the table.
    var adPosition = -1 // Default value
    var article: Article
    
    init(selectedArticle: Article) {
        article = selectedArticle
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
            let blockIndex = getBlockIndex(indexPath.row)
            if(blockIndex <= ArticleDetailManager.sharedInstance.articleBlocks.count-1 && blockIndex >= 0){
                let articleBlock = ArticleDetailManager.sharedInstance.articleBlocks.objectAtIndex(blockIndex) as ArticleBlock
                // return ArticleTextBlockTableViewCell.cellHeight(articleBlock.text)
                return ArticleTextBlockTableViewCell.cellHeight()
            }
            
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
                
            }
            else {
                cell = ArticleCoverTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: articleCoverIdentifier)
                cell?.selectionStyle = UITableViewCellSelectionStyle.None
                // cell?.coverImageView.image = article.coverImage.image

            }
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
                cell?.selectionStyle = UITableViewCellSelectionStyle.None
            }
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
                cell?.selectionStyle = UITableViewCellSelectionStyle.None
            }
            
            let blockIndex = getBlockIndex(indexPath.row)
            if(blockIndex <= ArticleDetailManager.sharedInstance.articleBlocks.count-1 && blockIndex >= 0){
                let articleBlock = ArticleDetailManager.sharedInstance.articleBlocks.objectAtIndex(blockIndex) as ArticleBlock
                // cell?.paragraph.text = articleBlock.text
                // cell?.updateFrame(articleBlock.text)
            }
            return cell!
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Select \(indexPath.row)")
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func getBlockIndex(currentIndexRow: Int) -> Int{
        
        var blockIndex = -1;
        if (currentIndexRow < adPosition && currentIndexRow > 0){
            blockIndex = currentIndexRow-1
        }
        else if (currentIndexRow > adPosition){
            blockIndex = currentIndexRow-2
        }
        return blockIndex
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
