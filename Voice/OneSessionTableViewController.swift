//
//  OneSectionTableViewController.swift
//  Voice
//
//  Created by Yi Qin on 1/13/15.
//  Copyright (c) 2015 yiqin. All rights reserved.
//

import UIKit

class OneSessionTableViewController: UITableViewController, UITableViewDelegate {
    
    var session : Session
    
    init(selectedSession: Session) {
        session = selectedSession
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
        return session.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return 300
        }
        else {
            return ArticleTableViewCell.cellHeight()
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let sessionStreetImageBlockIdentifier = "SessionStreetImageIdentifier"
        let sessionArticleIdentifier = "SessionArticleIdentifier"
        
        if (indexPath.row == 0){
            var cell = tableView.dequeueReusableCellWithIdentifier(sessionStreetImageBlockIdentifier) as? SessionStreetImageTableViewCell
            
            if cell != nil {
                
            }
            else {
                cell = SessionStreetImageTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: sessionStreetImageBlockIdentifier)
                cell?.selectionStyle = UITableViewCellSelectionStyle.None
                // cell?.coverImageView.image = article.coverImage.image
                
            }
            return cell!
        }
        else {
            var cell = tableView.dequeueReusableCellWithIdentifier(sessionArticleIdentifier) as? SessionArticleTableViewCell
            
            if cell != nil {
                // println("Cell exist")
            }
            else {
                // println("Create new Cell")
                cell = SessionArticleTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: sessionArticleIdentifier)
                cell?.selectionStyle = UITableViewCellSelectionStyle.None
            }
            
            return cell!
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Select \(indexPath.row)")
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }


}
