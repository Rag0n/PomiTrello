//
//  ListsTableViewController.swift
//  PomiTrello
//
//  Created by Александр on 23.09.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit

class ListsTableViewController: UITableViewController {
    var board: Board!

    
    // MARK: - View LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        refresh()
    }
    
    func refresh() {
        if refreshControl != nil {
            refreshControl?.beginRefreshing()
        }
        refresh(refreshControl)
    }
    
    @IBAction func refresh(sender: UIRefreshControl?) {
        board.loadLists { () -> Void in
            sender?.endRefreshing()
            self.tableView.reloadData()
        }
    }

    // MARK: - TableView Datasource

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return board.lists.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("List cell", forIndexPath: indexPath)
        
        let list = board.lists[indexPath.row]
        cell.textLabel?.text = list.name

        return cell
    }
    
    
    // MARK: - TableView Delegate

    
    // MARK: - Navigation


    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Show cards" {
            if let cvc = segue.destinationViewController as? CardsTableViewController {
                if let indexPath = tableView.indexPathForCell(sender as! UITableViewCell) {
                    cvc.list = board.lists[indexPath.row]
                }
            }
        }
    }
}
