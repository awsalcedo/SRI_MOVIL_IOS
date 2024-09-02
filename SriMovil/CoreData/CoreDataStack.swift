//
//  CoreDataStack.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 13/8/24.
//

import Foundation
import CoreData

class CoreDataStack {
    public static let shared = CoreDataStack()
    
    public let persistentContainer: NSPersistentContainer
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "SriModel")
        persistentContainer.loadPersistentStores { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
    }
    
    public var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
}
