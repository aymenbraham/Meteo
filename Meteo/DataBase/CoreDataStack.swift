//
//  CoreDataStack.swift
//  Meteo
//
//  Created by aymen braham on 21/04/2023.
//

import Foundation
import CoreData

protocol CoreDataStackProtocol {
    var managedContext: NSManagedObjectContext { get set }
    var storeContainer: NSPersistentContainer { get set }
    func saveContext() -> CoreStackSaveResult
}

enum CoreStackSaveResult {
    case success
    case noChanges
    case failure(Error)
}

class CoreDataStack: CoreDataStackProtocol {
    public static let modelName = "Meteo"

    public lazy var storeContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: CoreDataStack.modelName)
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()

    lazy var managedContext: NSManagedObjectContext = self.storeContainer.viewContext

    func saveContext() -> CoreStackSaveResult {
        guard managedContext.hasChanges else {
            return CoreStackSaveResult.noChanges
        }
        do {
            try managedContext.save()
            return CoreStackSaveResult.success
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
            managedContext.rollback()
            return CoreStackSaveResult.failure(error)
        }
    }
}
