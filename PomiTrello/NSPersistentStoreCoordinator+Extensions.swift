//
//  NSPersistentStoreCoordinator+Extensions.swift
//  PomiTrello
//
//  Created by Александр on 23.10.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import CoreData

extension NSPersistentStoreCoordinator {
    // создаем координатор для модели
    public static func coordinatorForModelWithName(name: String, inBundle bundle: NSBundle) -> NSPersistentStoreCoordinator {
        let model = NSManagedObjectModel.modelNamed(name, inBundle: bundle)
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        let url = storeURLForName(name)
        
        try! coordinator.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: url, options: nil)
        
        return coordinator
    }
    
    // получаем url для хранения бд
    private static func storeURLForName(name: String) -> NSURL {
        let fm = NSFileManager.defaultManager()
        let documentDirURL = try! fm.URLForDirectory(.DocumentDirectory, inDomain: .UserDomainMask, appropriateForURL: nil, create: true)
        return documentDirURL.URLByAppendingPathComponent(name).URLByAppendingPathExtension("pomodoro")
    }
}
