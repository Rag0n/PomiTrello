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
    @NSManaged private(set) var completedDate: NSDate?
    
    
    
}

extension Pomodoro: ManagedObjectType {
    public static var entityName: String {
        return "Pomodoro"
    }
    
    public static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: "completedDate", ascending: false)]
    }
    
    public static var defaultPredicate: NSPredicate? {
        return nil
    }
}