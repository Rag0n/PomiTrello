//
//  ManagedObject.swift
//  PomiTrello
//
//  Created by Александр on 05.10.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import CoreData


public class ManagedObject: NSManagedObject {
    // загружаем модель БД
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


// каждый entity должен подтвреждать этот протокол
public protocol ManagedObjectType: class {
    static var entityName: String { get }
    static var defaultSortDescriptors: [NSSortDescriptor] { get }
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
        return request
    }
}