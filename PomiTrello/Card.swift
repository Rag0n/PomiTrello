//
//  Card.swift
//  PomiTrello
//
//  Created by Александр on 26.09.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import Foundation
import CoreData

public final class Card: ManagedObject {
    @NSManaged private(set) var id: String!
    @NSManaged private(set) var name: String!
    @NSManaged private(set) var pos: Int32
    @NSManaged private(set) var pomodoros: Set<Pomodoro>
    
    // API для инкапсуляции создания объекта
    public static func insertIntoContext(moc: NSManagedObjectContext, name: String, id: String) -> Card {
        let card: Card = moc.insertObject()
        card.id = id
        card.name = name
        return card
    }
    
    public static func insertIntoContext(moc: NSManagedObjectContext, name: String, id: String, pos: Int32) -> Card {
        let card: Card = moc.insertObject()
        card.id = id
        card.name = name
        card.pos = pos
        return card
    }
    
    public func setCardName(name: String?) {
        guard let name = name else { return }
        self.name = name
    }
}


extension Card: ManagedObjectType {
    public static var entityName: String {
        return "Card"
    }
    
    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "pos", ascending: false)]
    }
    
    public static var defaultPredicate: NSPredicate? {
        return nil
    }
}