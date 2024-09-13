//
//  CoreDataDatabase.swift
//  SriMovil
//
//  Created by usradmin on 5/9/24.
//

import Foundation
import CoreData

///Implementación concreta que usa CoreData para cumplir con el protocolo LocalDatabaseType

class CoreDataDatabase: LocalDatabaseType {
    
    var managedObjectContext: NSManagedObjectContext {
        return CoreDataStack.shared.persistentContainer.viewContext
    }
    
    
}
