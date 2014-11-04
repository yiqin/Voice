//
//  NewsTableViewController.swift
//  Voice
//
//  Created by yiqin on 10/22/14.
//  Copyright (c) 2014 yiqin. All rights reserved.
//

import UIKit

protocol ArticlesTableViewControllerDelegate {
    func moveToSelectArticle(selectedArticle:Article)
}

class ArticlesTableViewController: UITableViewController {
    
    var messageLabel = UILabel()
    var delegate:ArticlesTableViewControllerDelegate?
   
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.view.backgroundColor = UIColor.whiteColor()
        self.tableView.separatorColor = UIColor.clearColor()
    }
    
    override init(style: UITableViewStyle) {
        super.init(style: style)
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Leaftagger.tagLeafOnViewController(self)
        
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.backgroundColor = UIColor.purpleColor()
        self.refreshControl?.tintColor = UIColor.whiteColor()
        
        self.refreshControl?.addTarget(self, action: "getLatestArticles", forControlEvents: .ValueChanged)
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
    func getLatestArticles() {
        ArticlesManager.sharedInstance.startLoadingDataFromParse()
        
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            self.tableView.reloadData()
        })
        
        if ((self.refreshControl) != nil){
            self.refreshControl?.endRefreshing()
        }
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
        if ArticlesManager.sharedInstance.articles.count == 0 {
            messageLabel.frame = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), CGRectGetHeight(self.view.frame))
            messageLabel.text = "No data is currently available. Please pull down to refresh."
            messageLabel.textColor = UIColor.blackColor()
            messageLabel.numberOfLines = 0
            messageLabel.textAlignment = NSTextAlignment.Center
            messageLabel.font = UIFont(name: "Palatino-Italic", size: 20)
            
            messageLabel.sizeToFit()
            messageLabel.frame = CGRectMake(0, 80, CGRectGetWidth(messageLabel.frame), CGRectGetHeight(messageLabel.frame))
            self.tableView.addSubview(messageLabel)
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            return 1
        }
        else {
            messageLabel.removeFromSuperview()
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine    // This is not a good UI.
            return ArticlesManager.sharedInstance.articles.count
        }
        
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 130
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var articles = ArticlesManager.sharedInstance.articles
        let articleIdentifier = "ArticleIdentifier"
        var cell = tableView.dequeueReusableCellWithIdentifier(articleIdentifier) as? ArticleTableViewCell
        
        if articles.count == 0 {
            return UITableViewCell()
        }
        else {
            
            if cell != nil {
                // println("Cell exist")
                
            }
            else {
                // println("Create new Cell")
                cell = ArticleTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: articleIdentifier, tableWidth: DeviceManager.sharedInstance.screenWidth)
            }
            cell?.loadCellFromArticle(articles.objectAtIndex(indexPath.row) as Article)
            
            return cell!
            // cell?.title.text = articles.objectAtIndex(indexPath.row).title
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Select \(indexPath.row)")
        var articles = ArticlesManager.sharedInstance.articles
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        delegate?.moveToSelectArticle(articles.objectAtIndex(indexPath.row) as Article)
        
    }
    
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView!, canEditRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
    // Return NO if you do not want the specified item to be editable.
    return true
    }
    */
    
    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView!, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath!) {
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
    override func tableView(tableView: UITableView!, moveRowAtIndexPath fromIndexPath: NSIndexPath!, toIndexPath: NSIndexPath!) {
    
    }
    */
    
    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView!, canMoveRowAtIndexPath indexPath: NSIndexPath!) -> Bool {
    // Return NO if you do not want the item to be re-orderable.
    return true
    }
    */
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    }
    */
    
}
