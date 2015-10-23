//
//  PomodoroStack.swift
//  PomiTrello
//
//  Created by Александр on 23.10.15.
//  Copyright © 2015 Alexander. All rights reserved.
//

import Foundation
import CoreData

private let ModelName = "Pomodoro"

public func createPomodoroMainContext() -> NSManagedObjectContext {
    let bundle = NSBundle(forClass: Card.self)
    let coordinator = NSPersistentStoreCoordinator.coordinatorForModelWithName(ModelName, inBundle: bundle)
}