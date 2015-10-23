//
//  NSManagedObjectContextExtensions.swift
//  PomiTrello
//
//  Created by Александр on 07.10.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import CoreData

extension NSManagedObjectContext {

    // API создания нового объекта в контексте
    public func insertObject<A: ManagedObject where A: ManagedObjectType>() -> A {
        guard let obj = NSEntityDescription.insertNewObjectForEntityForName(A.entityName, inManagedObjectContext: self) as? A else {
            fatalError("Wrong object type")
        }
        return obj
    }
    
    public static func mainContextForCoordinator(coordinator: NSPersistentStoreCoordinator) -> NSManagedObjectContext {
        let context = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        context.persistentStoreCoordinator = coordinator
        return context
    }
    
}

extension NSManagedObjectContext {
    
    // проверяем на ошибку при сохранении, если есть - откатываемся назад
    public func saveOrRollBack() -> Bool {
        do {
            try save()
            return true
        } catch {
            rollback()
            return false
        }
    }
    
    // выполняет замыкания и сохраняет контекст на корректной очереди задач
    public func performChanges(block: () -> ()) {
        performBlock {
            block()
            self.saveOrRollBack()
        }
    }
}