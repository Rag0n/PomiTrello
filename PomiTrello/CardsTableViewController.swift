//
//  CardsTableViewController.swift
//  PomiTrello
//
//  Created by Александр on 26.09.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit

class CardsTableViewController: UITableViewController {

    var list: List!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = list.name
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        refresh()
    }
    
    func refresh() {
        if refreshControl != nil {
            refreshControl?.beginRefreshing()
        }
        refresh(refreshControl)
    }

    @IBAction func refresh(sender: UIRefreshControl?) {
        list.loadCards() { () -> Void in
            sender?.endRefreshing()
            self.tableView.reloadData()
        }
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.cards.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Card cell", forIndexPath: indexPath) as! CardsTableViewCell
        cell.card = list.cards[indexPath.row]

        return cell
    }


    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "Show pomodoro" {
            if let pvc = segue.destinationViewController as? PomodoroViewController {
                if let indexPath = tableView.indexPathForCell(sender as! CardsTableViewCell) {
                    pvc.card = list.cards[indexPath.row]
                }
            }
        }
    }


}
