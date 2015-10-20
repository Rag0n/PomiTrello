//
//  ManagedObjectContextSettable.swift
//  PomiTrello
//
//  Created by Александр on 20.10.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import CoreData

protocol ManagedObjectContextSettable: class {
    var managedObjectContext: NSManagedObjectContext! { get set }
}
