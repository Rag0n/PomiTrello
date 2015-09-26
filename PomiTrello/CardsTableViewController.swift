//
//  CardsTableViewController.swift
//  PomiTrello
//
//  Created by Александр on 26.09.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit

class CardsTableViewController: UITableViewController {
    var cards = [Card]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cards.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Card cell", forIndexPath: indexPath)
        let card = cards[indexPath.row]
        cell.textLabel?.text = card.name

        return cell
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
