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


    override func viewDidLoad() {
        super.viewDidLoad()
        board.loadLists { () -> Void in
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
