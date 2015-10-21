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
    
    var managedObjectContext: NSManagedObjectContext!
    
    // MARK: Private
    
    private typealias Data = FetchedResultsDataProvider<CardsTableViewController>
    private var dataSource: TableViewDataSource<CardsTableViewController, Data, CardsTableViewCell>!
    
//    let cellIdentifier = "CardCell"
//    var cardsDataSource: CardsDataSource!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func setupTableView() {
//        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: cellIdentifier)
//        
//        cardsDataSource = CardsDataSource(withItems: cards, cellIdentifier: cellIdentifier, configureCell: configureCell)
//        tableView.dataSource = cardsDataSource
        // self sizing cells
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        
        let request = Card.sortedFetchRequest
        request.returnsObjectsAsFaults = false
        request.fetchBatchSize = 20
        
        let frc = NSFetchedResultsController(fetchRequest: request, managedObjectContext: managedObjectContext, sectionNameKeyPath: nil, cacheName: nil)
        let dataProvider = FetchedResultsDataProvider(fetchedResultsController: frc, delegate: self)
        dataSource = TableViewDataSource(tableView: tableView, dataProvider: dataProvider, delegate: self)
    }
    
    func configureCell(cell: UITableViewCell, item: AnyObject) {
        cell.textLabel?.text = (item as! Card).name
    }
}

extension CardsTableViewController : DataProviderDelegate {
    func dataProviderDidUpdate(updates: [DataProviderUpdate<Card>]?) {
        dataSource.processUpdates(updates)
    }
}

extension CardsTableViewController : DataSourceDelegate {
    func cellIdentifierForObject(object: Card) -> String {
        return "CardCell"
    }
}