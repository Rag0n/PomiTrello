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


public protocol ManagedObjectType {
    static var entityName: String { get }
    static var defaultSortDescriptors: [NSSortDescriptor] { get }
}


extension ManagedObjectType {
    
    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return []
    }
    
    // fetch request with default sort descriptors
    public static var sortedFetchRequest: NSFetchRequest {
        let request = NSFetchRequest(entityName: entityName)
        request.sortDescriptors = defaultSortDescriptors
        return request
    }
}