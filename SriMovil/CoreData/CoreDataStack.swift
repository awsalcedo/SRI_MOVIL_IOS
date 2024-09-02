//
//  CoreDataStack.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 13/8/24.
//

import Foundation
import CoreData

class CoreDataStack {
    static let shared = CoreDataStack()
    
    private let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "ModelName") // Usa el nombre de tu modelo de datos
        container.loadPersistentStores { (description, error ) in
            if let error = error {
                print("ERROR LOADING CORE DATA. \(error)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    func saveContext() throws {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                throw CoreDataError.saveError(error)
            }
        }
    }
}
