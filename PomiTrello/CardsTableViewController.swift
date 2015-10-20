//
//  CardsPrototypeTableViewController.swift
//  PomiTrello
//
//  Created by Александр on 12.10.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit
import CoreData

class CardsTableViewController: UITableViewController, ManagedObjectContextSettable {
    
    var cards = [Card]()
    var managedObjectContext: NSManagedObjectContext!
    
    let cellIdentifier = "CardCell"
    var cardsDataSource: CardsDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        
        cardsDataSource = CardsDataSource(withItems: cards, cellIdentifier: cellIdentifier, configureCell: configureCell)
        tableView.dataSource = cardsDataSource
    }
    
    func configureCell(cell: UITableViewCell, item: AnyObject) {
        cell.textLabel?.text = (item as! Card).name
    }
}
