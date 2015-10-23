//
//  NSManagedObjectModel+Extensions.swift
//  PomiTrello
//
//  Created by Александр on 23.10.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import CoreData

extension NSManagedObjectModel {
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