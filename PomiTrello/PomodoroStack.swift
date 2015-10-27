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
    // будет работать, если перенесем в другой модуль
    let bundle = NSBundle(forClass: Card.self)
    // конфигурируем координатор(модель, persistent store)
    let coordinator = NSPersistentStoreCoordinator.coordinatorForModelWithName(ModelName, inBundle: bundle)
    // создаем контекст в main thread
    let context = NSManagedObjectContext.mainContextForCoordinator(coordinator)
    
    return context
}