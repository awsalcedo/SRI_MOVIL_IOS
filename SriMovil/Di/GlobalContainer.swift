//
//  GlobalContainer.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 13/8/24.
//

import Foundation
import CoreData
import Factory

extension Container {
    
    // CoreData
    
    // CoreData Managed Object Context
    var managedObjectContext: Factory<NSManagedObjectContext> {
        self {
            let container = CoreDataStack.shared.persistentContainer
            return container.viewContext
        }.singleton
    }
    
    var persistentContainer: Factory<NSPersistentContainer> {
        self { CoreDataStack.shared.persistentContainer }.singleton
    }
    
    // URLSession
    var session: Factory<URLSession> {
        self { URLSession.shared }.singleton
    }
    
    // HTTPClient
    var httpClient: Factory<HTTPClient> {
        self { HTTPClient() }.singleton
    }
    
}
