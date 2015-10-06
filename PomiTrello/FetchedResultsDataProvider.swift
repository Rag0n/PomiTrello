//
//  FetchedResultsDataProvider.swift
//  PomiTrello
//
//  Created by Александр on 06.10.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import CoreData

// know about all underlying data changes
class FetchedResultsDataProvider<Delegate: DataProviderDelegate> : NSObject, NSFetchedResultsControllerDelegate, DataProvider {
    
    typealias Object = Delegate.Object
    
    init(fetchedResultController: NSFetchedResultsController, delegate: Delegate) {
        self.fetchedResultsController = fetchedResultController
        self.delegate = delegate
        super.init()
        fetchedResultsController.delegate = self
        try! fetchedResultsController.performFetch()
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        
    }
    
    
    // MARK: - DataProvider Protocol
    func objectAtIndexPath(indexPath: NSIndexPath) -> Object {
        guard let result = fetchedResultsController.objectAtIndexPath(indexPath) as? Object else {
            fatalError("Unexpected object at \(indexPath)")
        }
        return result
    }
    
    func numberOfItemsInSection(section: Int) -> Int {
        guard let sec = fetchedResultsController.sections?[section] else { return 0 }
        return sec.numberOfObjects
    }
    
    // MARK: - Private
    private let fetchedResultsController: NSFetchedResultsController
    private weak var delegate: Delegate!
}
