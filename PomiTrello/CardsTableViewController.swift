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
    
    var pos: Int32 = 0
    var managedObjectContext: NSManagedObjectContext!
    
    // MARK: ViewController LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    // MARK: Private
    
    private typealias Data = FetchedResultsDataProvider<CardsTableViewController>
    private var dataSource: TableViewDataSource<CardsTableViewController, Data, CardsTableViewCell>!
    
    private func setupTableView() {
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
    
    // MARK: IBActions
    @IBAction func add(sender: UIBarButtonItem) {
        let id = NSUUID.init()
        self.managedObjectContext.performBlock() {
            Card.insertIntoContext(managedObjectContext, name: "Test \(id.UUIDString)", id: "\(id.UUIDString)", pos: pos)
        }
        pos++
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