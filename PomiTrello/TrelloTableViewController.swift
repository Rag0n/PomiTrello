//
//  TrelloTableViewController.swift
//  PomiTrello
//
//  Created by Александр on 19.09.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit
import CoreData

class TrelloTableViewController: UITableViewController, ManagedObjectContextSettable, SegueHandlerType {
    
    enum SegueIdentifier: String {
        case ShowLists = "showLists"
    }

    // MARK: - Public API
    var boards = [Board]()
    var managedObjectContext: NSManagedObjectContext!
    
    
    // MARK: - ViewController LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Boards"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "createNewBoard")
//        refresh()
        setupTableView()
    }
    
    // MARK: Temp code
    var position: Int32 = 0
    func createNewBoard() {
        self.managedObjectContext.performBlock {
            Board.insertIntoContext(self.managedObjectContext, position: self.position++, id: "id  \(self.position)", name: "New Board \(self.position)", desc: "Board description", url: NSURL(string: "board url \(self.position)")!)
        }
    }
    
//    func refresh() {
//        if refreshControl != nil {
//            refreshControl?.beginRefreshing()
//        }
//        refresh(refreshControl)
//    }
//
//    @IBAction func refresh(sender: UIRefreshControl?) {
//        do {
//            try Board.loadBoards({ (boards) -> Void in
//                self.boards = boards
//                sender?.endRefreshing()
//                self.tableView.reloadData()
//            })
//        } catch Errors.CantLoadBoards {
//            print("Cant load boards")
//        } catch {
//            print("Something went wrong :(")
//        }
//    }
    
    
    // MARK: - Private
    private typealias Data = FetchedResultsDataProvider<TrelloTableViewController>
    private var dataSource: TableViewDataSource<TrelloTableViewController, Data, TrelloTableViewCell>!
    
    // initializing fetched result controller
    private func setupTableView() {
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
        let request = Board.sortedFetchRequest
        request.fetchBatchSize = 20
        request.returnsObjectsAsFaults = false
        
        let frc = NSFetchedResultsController(fetchRequest: request,
            managedObjectContext: managedObjectContext,
            sectionNameKeyPath: nil, cacheName: nil)
        let dataProvider = FetchedResultsDataProvider(
            fetchedResultsController: frc, delegate: self)
        
        dataSource = TableViewDataSource(tableView: tableView, dataProvider: dataProvider, delegate: self)
        
    }
    
    // MARK: - Navigation
//    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
//        switch segueIdentifierForSegue
//        if segue.identifier == "Show list" {
//            if let ltvc = segue.destinationViewController as? ListsTableViewController {
//                let indexPath = tableView.indexPathForCell(sender as! UITableViewCell)!
//                ltvc.board = boards[indexPath.row]
//            }
//        }
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segueIdentifierForSegue(segue) {
        case .ShowLists:
            guard let vc = segue.destinationViewController as? ListsTableViewController else {
                fatalError("Wrong View Controller Type")
            }
//            guard let board = dataSource.selected
        }
    }
}


extension TrelloTableViewController: DataProviderDelegate {
    // passing updates from data provider to data source
    func dataProviderDidUpdate(updates: [DataProviderUpdate<Board>]?) {
        dataSource.processUpdates(updates)
    }
}

extension TrelloTableViewController: DataSourceDelegate {
    func cellIdentifierForObject(object: Object) -> String {
        return "BoardCell"
    }
}
