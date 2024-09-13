//
//  LocalDatabaseType.swift
//  SriMovil
//
//  Created by usradmin on 5/9/24.
//

import Foundation
import CoreData

/// Define una abstracción general para el acceso a la base de datos local

protocol LocalDatabaseType {
    var managedObjectContext: NSManagedObjectContext { get }
}
