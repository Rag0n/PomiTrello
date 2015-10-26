//
//  ManagedObject.swift
//  PomiTrello
//
//  Created by Александр on 05.10.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import CoreData


public class ManagedObject: NSManagedObject {

}


// каждый entity должен подтвреждать этот протокол
public protocol ManagedObjectType: class {
    static var entityName: String { get }
    static var defaultSortDescriptors: [NSSortDescriptor] { get }
    static var defaultPredicate: NSPredicate? { get }
    var managedObjectContext: NSManagedObjectContext? { get }
}


extension ManagedObjectType {
    
    // сортировка по умолчанию
    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return []
    }
    
    // запрос с дефолтным дескриптором сортировки
    public static var sortedFetchRequest: NSFetchRequest {
        let request = NSFetchRequest(entityName: entityName)
        request.sortDescriptors = defaultSortDescriptors
        if let predicate = defaultPredicate {
            request.predicate = predicate
        }
        return request
    }
}