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

class ArticlesTableViewController: UITableViewController, SWTableViewCellDelegate {
    
    var messageLabel = UILabel()
    var delegate:ArticlesTableViewControllerDelegate?
    
    /// Record the content offset of the article table view controller. Update when the user scroll the article table view.
    var lastContentOffset : CGFloat
    /// Bottom line of the article table view controller
    var lastBottomLine : CGFloat
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        lastContentOffset = 0
        lastBottomLine = 0
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.view.backgroundColor = UIColor.whiteColor()
        self.tableView.separatorColor = UIColor.clearColor()
    }
    
    override init(style: UITableViewStyle) {
        lastContentOffset = 0
        lastBottomLine = 0
        super.init(style: style)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
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
        ArticlesManager.sharedInstance.startLoadingDataFromParse(0, completionClosure: { (success) -> () in
            if (success){
                self.tableView.reloadData()
                if ((self.refreshControl) != nil){
                    self.refreshControl?.endRefreshing()
                }
            }
        })
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
            // self.tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine    // This is not a good UI.
            self.tableView.separatorStyle = UITableViewCellSeparatorStyle.None
            return ArticlesManager.sharedInstance.articles.count+1
        }
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var articles = ArticlesManager.sharedInstance.articles
        if (indexPath.row < articles.count) {
            return ArticleTableViewCell.cellHeight()
        }
        else {
            return ArticleLoadMoreDataTableViewCell.cellHeight()
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let articleIdentifier = "ArticleIdentifier"
        let articleLoadMoreDataIdentifier = "ArticleLoadMoreData"
        
        var articles = ArticlesManager.sharedInstance.articles
        if articles.count == 0 {
            return UITableViewCell()
        }
        else if (indexPath.row < articles.count) {
            
            var cell = tableView.dequeueReusableCellWithIdentifier(articleIdentifier) as? ArticleTableViewCell
            
            if cell != nil {
                // println("Cell exist")
                
            }
            else {
                // println("Create new Cell")
                cell = ArticleTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: articleIdentifier, tableWidth: DeviceManager.sharedInstance.screenWidth)
                cell?.leftUtilityButtons = leftButtons()
                cell?.rightUtilityButtons = rightButtons()
                cell?.delegate = self
            }
            cell?.indexPath = indexPath // Track the indexPath on Cell
            
            var article = articles.objectAtIndex(indexPath.row) as Article
            
            if(article.isFirstLoad){
                let thunmbnail = article.briefImagePFFile
                cell?.briefImage.file = thunmbnail
                cell?.briefImage.image = UIImage(named: "defaultImage.png")
                
                cell?.briefImage.loadInBackground { (image:UIImage!, error: NSError!) -> Void in
                    println("Load Image ssauccesfully.")
                }
            }
            cell?.loadCellFromArticle(article)
            return cell!
        }
        else {
            var cell = tableView.dequeueReusableCellWithIdentifier(articleLoadMoreDataIdentifier) as? ArticleLoadMoreDataTableViewCell
            if cell != nil {
                
            }
            else {
                cell = ArticleLoadMoreDataTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: articleLoadMoreDataIdentifier)
            }
            
            cell?.textLabel.text = "Load More Data"
            return cell!
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Select \(indexPath.row)")
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        let articles = ArticlesManager.sharedInstance.articles
        
        if (indexPath.row < articles.count) {
            let selectedArticle = articles.objectAtIndex(indexPath.row) as Article
            selectedArticle.startLoadWholeArticle()
            delegate?.moveToSelectArticle(selectedArticle)
        } else {
            ArticlesManager.sharedInstance.loadMoreDataFromParse({ (success) -> Void in
                if (success){
                    self.tableView.reloadData()
                }
            })
        }
    }
    
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        lastContentOffset = scrollView.contentOffset.y
    }
    
    /**
     Update Scroll View When AssistantHorizontalView is moving.
     */
    func updateScrollView(bottomLine:CGFloat){
        var deltaBottomLine = bottomLine - lastBottomLine
        
        if (self.lastContentOffset > 0.0) {
            self.tableView.setContentOffset(CGPointMake(0, self.lastContentOffset-deltaBottomLine), animated: false)
        }
        else if (self.lastContentOffset == 0.0 && deltaBottomLine < 0) {
            self.tableView.setContentOffset(CGPointMake(0, -deltaBottomLine), animated: false)
        }
        
        lastBottomLine = bottomLine
    }
    
    class func initContentOffset() -> CGFloat {
        return ArticleTableViewCell.cellHeight()*4
    }
    
    
    
    func rightButtons() -> NSArray {
        var rightUtilityButtons = NSMutableArray()
        
        rightUtilityButtons.sw_addUtilityButtonWithColor(UIColor(red: 1.0, green: 0.231, blue: 0.188, alpha: 1.0), title: "")
        rightUtilityButtons.sw_addUtilityButtonWithColor(UIColor(red: 1.0, green: 0.231, blue: 0.188, alpha: 1.0), title: "")
        rightUtilityButtons.sw_addUtilityButtonWithColor(UIColor(red: 1.0, green: 0.231, blue: 0.188, alpha: 1.0), title: "Hide")
        
        return rightUtilityButtons
    }
    
    func leftButtons() -> NSArray {
        var leftUtilityButtons = NSMutableArray()
        
        return leftUtilityButtons
    }
    
    
    
    
    func swipeableTableViewCell(cell: SWTableViewCell!, scrollingToState state: SWCellState) {
        switch state {
        case SWCellState.CellStateCenter:
            break
        case SWCellState.CellStateLeft:
            break
        case SWCellState.CellStateRight:
            hideArticleFromTableView(cell)
            break
        default:
            break
        }
    }
    
    func swipeableTableViewCell(cell: SWTableViewCell!, didTriggerLeftUtilityButtonWithIndex index: Int) {
        
    }
    
    func swipeableTableViewCell(cell: SWTableViewCell!, didTriggerRightUtilityButtonWithIndex index: Int) {
        
    }
    
    func swipeableTableViewCellShouldHideUtilityButtonsOnSwipe(cell: SWTableViewCell!) -> Bool {
        return true
    }
    
    func swipeableTableViewCell(cell: SWTableViewCell!, canSwipeToState state: SWCellState) -> Bool {
        return true
    }
    
    func hideArticleFromTableView(cell: SWTableViewCell!) {
        println(cell.indexPath.row)
        println(cell.indexPath.section)
        
        // self.tableView.beginUpdates()
        ArticlesManager.sharedInstance.removeArticle(cell.indexPath.row)
        
        let path = NSIndexPath(forRow: cell.indexPath.row, inSection: cell.indexPath.section)
        let indexArray = [path] as NSArray
        
        // This animation is not perfect, but works.
        self.tableView.deleteRowsAtIndexPaths(indexArray, withRowAnimation: UITableViewRowAnimation.Left)
        
        self.tableView.reloadData()
        // self.tableView.endUpdates()
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
