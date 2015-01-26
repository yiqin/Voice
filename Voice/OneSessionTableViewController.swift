//
//  OneSectionTableViewController.swift
//  Voice
//
//  Created by Yi Qin on 1/13/15.
//  Copyright (c) 2015 yiqin. All rights reserved.
//

import UIKit

protocol OneSessionTableViewControllerDelegate {
    func moveToSelectArticle(selectedArticle:Article)
    func moveToSelectStreetImageFromImageRows(selectedStreetImage:StreetImage)
}

class OneSessionTableViewController: UITableViewController, UITableViewDelegate {
    
    var session : Session
    var delegate: OneSessionTableViewControllerDelegate?
    
    init(selectedSession: Session) {
        session = selectedSession
        super.init(nibName: nil, bundle: nil)    // this has a higher priority.
        
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            if(session.isLoading){
                let ratio =  DeviceManager.sharedInstance.screenWidth/400
                return 600*ratio
            }
            else {
                let image = session.streetImage.uiimage
                let ratio = DeviceManager.sharedInstance.screenWidth/image.size.width
                return image.size.height*ratio
            }
        }
        else {
            return SessionArticleTableViewCell.cellHeight()
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
            }
            
            cell?.updateCell(session.streetImage, session: session)
            
            return cell!
        }
        else {
            var cell = tableView.dequeueReusableCellWithIdentifier(sessionArticleIdentifier) as? SessionArticleTableViewCell
            
            if cell != nil {
                
                println("hi.... reuse table view cell")
                
            }
            else {
                cell = SessionArticleTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: sessionArticleIdentifier)
                cell?.selectionStyle = UITableViewCellSelectionStyle.None
            }
            
            let article = session.articles[indexPath.row-1] as Article
            cell?.updateCell(article)
            
            return cell!
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("Select \(indexPath.row)")
        tableView.deselectRowAtIndexPath(indexPath, animated: true)

        if (indexPath.row == 0){
            delegate?.moveToSelectStreetImageFromImageRows(session.streetImage)
        }
        else {
            let article = session.articles[indexPath.row-1] as Article
            delegate?.moveToSelectArticle(article)
        }
    }
    

    
}
