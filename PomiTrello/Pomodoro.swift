//
//  Pomodoro.swift
//  PomiTrello
//
//  Created by Александр on 27.10.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import Foundation
import CoreData

public final class Pomodoro: ManagedObject {
    @NSManaged private(set) var time: Int32
    @NSManaged private(set) var updatedAt: String
    @NSManaged private(set) var card: Card
    
    public static func insertIntoContext(moc: NSManagedObjectContext, card: Card) -> Pomodoro {
        let pomodoro: Pomodoro = moc.insertObject()
        pomodoro.time = 0
        pomodoro.card = card
        
        let currentDate = NSDate(timeIntervalSinceNow: 0)
        let currentDateFormatter = NSDateFormatter()
        currentDateFormatter.timeZone = NSTimeZone(forSecondsFromGMT: 0)
        currentDateFormatter.timeStyle = NSDateFormatterStyle.ShortStyle
        // TODO: Исправить на dateFormat
        currentDateFormatter.dateStyle = NSDateFormatterStyle.ShortStyle
        // TODO: Исправить на локализацию пользователя
        currentDateFormatter.locale = NSLocale(localeIdentifier: "ru_Ru")
        
        pomodoro.updatedAt = currentDateFormatter.stringFromDate(currentDate)
        
        return pomodoro
    }
}

extension Pomodoro: ManagedObjectType {
    public static var entityName: String {
        return "Pomodoro"
    }
    
    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: NSUpdatedObjectsKey, ascending: false)]
    }
    
    public static var defaultPredicate: NSPredicate? {
        return nil
    }
}

extension Pomodoro: UpdatedTimestampable {
    
}