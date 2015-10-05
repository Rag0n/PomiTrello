//
//  BoardStack.swift
//  PomiTrello
//
//  Created by Александр on 05.10.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import CoreData


private let ModelName = "Boards"

protocol ManagedObjectContextSettable: class {
    var managedObjectContext: NSManagedObjectContext! { get set }
}

public func createBoardsMainContext() -> NSManagedObjectContext {
    let bundle = NSBundle(forClass: Board.self)
    let coordinator = NSPersistentStoreCoordinator.coordinatorForModelWithName(ModelName, inBundle: bundle)
    let context = NSManagedObjectContext.mainContextForCoordinator(coordinator)
    return context
}


extension NSPersistentStoreCoordinator {
    // creating a coordinator instance for a model with a certain name located in a certain bundle
    public static func coordinatorForModelWithName(name: String, inBundle bundle: NSBundle) -> NSPersistentStoreCoordinator {
        let model = NSManagedObjectModel.modelNamed(name, inBundle: bundle)
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        let url = storeURLForName(name)
        try! coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        return coordinator
    }
    
    // making url of a persistent store(sqlite)
    private static func storeURLForName(name: String) -> NSURL {
        let fm = NSFileManager.defaultManager()
        let documentDirURL = try! fm.URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true)
        return documentDirURL.URLByAppendingPathComponent(name).URLByAppendingPathExtension("boards")
    }
    
}


extension NSManagedObjectModel {
    // loading a data model
    public static func modelNamed(name: String, inBundle bundle: NSBundle) -> NSManagedObjectModel {
        guard let modelURL = bundle.URLForResource(name, withExtension: "momd") else {
            fatalError("Managed object model not found")
        }
        guard let model = NSManagedObjectModel(contentsOfURL: modelURL) else {
            fatalError("Could not load managed object model from file \(modelURL)")
        }
        return model
    }

}


extension NSManagedObjectContext {
    // making managed object context with configured persistent store coordinator
    public static func mainContextForCoordinator(coordinator: NSPersistentStoreCoordinator) -> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        context.persistentStoreCoordinator = coordinator
        return context
    }
    
}