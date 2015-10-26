//
//  ManagedObjectObserver.swift
//  PomiTrello
//
//  Created by Александр on 26.10.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import Foundation
import CoreData


public final class ManagedObjectObserver {
    
    public enum ChangeType {
        case Delete
        case Update
    }
    
    public init?(object: ManagedObjectType, changeHandler: (ChangeType) -> ()) {
        guard let moc = object.managedObjectContext else { return nil }
        
    }
}
