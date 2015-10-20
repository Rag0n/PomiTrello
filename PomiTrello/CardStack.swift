//
//  CardStack.swift
//  PomiTrello
//
//  Created by Александр on 20.10.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import CoreData

private let StoreURL = NSURL.documentsURL.URLByAppendingPathComponent("Card.card")

public func createCardMainContext() -> NSManagedObjectContext {
    let bundle = NSBundle(forClass: Card.self)
    guard let model = NSManagedObjectModel.mergedModelFromBundles([bundle]) else {
        fatalError("model not found")
    }
    
    let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
    try psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: StoreURL, options: nil)
    
    let context = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
    context.persistentStoreCoordinator = psc
    
    return context
}
