//
//  TrelloTableViewController.swift
//  PomiTrello
//
//  Created by Александр on 19.09.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit

class TrelloTableViewController: UITableViewController {    
    var boards = [Board]()
    
    
    // MARK: - ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Boards"
        refresh()
    }
    
    func refresh() {
        if refreshControl != nil {
            refreshControl?.beginRefreshing()
        }
        refresh(refreshControl)
    }

    @IBAction func refresh(sender: UIRefreshControl?) {
        do {
            try Board.loadBoards({ (boards) -> Void in
                self.boards = boards
                sender?.endRefreshing()
                self.tableView.reloadData()
            })
        } catch Errors.CantLoadBoards {
            print("Cant load boards")
        } catch {
            print("Something went wrong :(")
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return boards.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Board cell", forIndexPath: indexPath) as UITableViewCell
        let board = boards[indexPath.row]
        
        cell.textLabel?.text = board.name
        
        return cell
    }
    

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Show list" {
            if let ltvc = segue.destinationViewController as? ListsTableViewController {
                let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!
                ltvc.board = boards[indexPath.row]
            }
        }
    }


}
