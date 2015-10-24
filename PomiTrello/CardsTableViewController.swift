//
//  CardsPrototypeTableViewController.swift
//  PomiTrello
//
//  Created by Александр on 12.10.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import UIKit
import CoreData

class CardsTableViewController: UITableViewController, ManagedObjectContextSettable, SegueHandlerType, UIPopoverPresentationControllerDelegate {
    
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
            if let ppc = vc.popoverPresentationController {
                // определяем минимальные размер окна с помощью auto layout
                let minimumSize = vc.view.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
                // если возможно, задаем ширину
                vc.preferredContentSize = CGSize(width: Constants.AddNewCardPopoverWidth, height: minimumSize.height)
                // доступ к методам адаптации iphone
                ppc.delegate = self
            }
        }
    }
    
    func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle {
        // модальный экран над текущим, а не вместо
        return UIModalPresentationStyle.OverFullScreen
    }
    
    func presentationController(controller: UIPresentationController, viewControllerForAdaptivePresentationStyle style: UIModalPresentationStyle) -> UIViewController? {
        return UINavigationController(rootViewController: controller.presentedViewController)
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
    
    private struct Constants {
        static let AddNewCardPopoverWidth: CGFloat = 320
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