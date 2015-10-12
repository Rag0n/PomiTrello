//
//  Card.swift
//  PomiTrello
//
//  Created by Александр on 26.09.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import Foundation
import CoreData

public final class Card {
//    @NSManaged private(set) var position: Int32
//    @NSManaged private(set) var id: String!
//    @NSManaged private(set) var name: String!
    
    var id: String!
    var name: String!
    
//    @NSManaged private(set) var list: List!
}

extension Card: ManagedObjectType {
    public static var entityName: String {
        return "Card"
    }
    
    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "position", ascending: false)]
    }
}