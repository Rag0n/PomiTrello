//
//  CardsPrototypeTableViewController.swift
//  PomiTrello
//
//  Created by Александр on 12.10.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit
import CoreData

class CardsTableViewController: UITableViewController, ManagedObjectContextSettable, SegueHandlerType {
    
    enum SegueIdentifier: String {
        case ShowCardDetail = "showCardDetail"
        case AddNewCard = "Add Card"
    }
    
    
    var managedObjectContext: NSManagedObjectContext!
    
    
    // MARK: ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segueIdentifierForSegue(segue) {
        case .ShowCardDetail:
            guard let vc = segue.destinationViewController.contentViewController as? CardDetailViewController else {
                fatalError("Wrong view controller")
            }
            guard let card = dataSource.selectedObject else {
                fatalError("Impossible to show detail without selected object")
            }
            vc.card = card
        case .AddNewCard:
            guard let vc = segue.destinationViewController.contentViewController as? AddNewCardViewController else {
                fatalError("Wrong view controller")
            }
        }
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
    
    
//    // MARK: IBActions
//    @IBAction func add(sender: UIBarButtonItem) {
//        let id = NSUUID.init()
//        self.managedObjectContext.performChanges {
//            Card.insertIntoContext(self.managedObjectContext, name: "Test \(id.UUIDString)", id: "\(id.UUIDString)", pos: self.pos)
//        }
//        pos++
//    }
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