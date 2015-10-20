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
    // получаем bundle(будет работать, если перенесем в другой модуль)
    let bundle = NSBundle(forClass: Card.self)
    
    // загружаем объектную модель
    guard let model = NSManagedObjectModel.mergedModelFromBundles([bundle]) else {
        fatalError("model not found")
    }
    
    // создаем persistent store coordinator для нашей модели и добавляем persistent store
    let psc = NSPersistentStoreCoordinator(managedObjectModel: model)
    try! psc.addPersistentStoreWithType(NSSQLiteStoreType, configuration: nil, URL: StoreURL, options: nil)
    
    // привязываем контекст к main thread
    // т.о можем безопасно обращаться к контексту в UI коде
    let context = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
    context.persistentStoreCoordinator = psc
    
    return context
}

extension NSURL {
    // возвращает url директории документов
    static var documentsURL: NSURL {
        let fileManager = NSFileManager.defaultManager()
        
        let urls = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        
        return urls[0]
    }
}
