//
//  NSManagedObjectContextExtensions.swift
//  PomiTrello
//
//  Created by Александр on 07.10.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import CoreData

extension NSManagedObjectContext {

    public func insertObject<A: ManagedObject where A: ManagedObjectType>() -> A {
        guard let obj = NSEntityDescription.insertNewObjectForEntityForName(A.entityName, inManagedObjectContext: self) as? A else {
            fatalError("Wrong object type")
        }
        return obj
    }
    
}

extension NSManagedObjectContext {
    public func saveOrRollBack() -> Bool {
        do {
            try save()
            return true
        } catch {
            rollback()
            return false
        }
    }
    
    // makes sure we'r in correct queue to make changes
    public func performChanges(block: () -> ()) {
        performBlock {
            block()
            self.saveOrRollBack()
        }
    }
}