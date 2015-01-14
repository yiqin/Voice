//
//  OneSectionTableViewController.swift
//  Voice
//
//  Created by Yi Qin on 1/13/15.
//  Copyright (c) 2015 yiqin. All rights reserved.
//

import UIKit

class OneSessionTableViewController: UITableViewController, UITableViewDelegate {
    
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

    

}
