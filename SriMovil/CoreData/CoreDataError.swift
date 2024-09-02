//
//  CoreDataError.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 13/8/24.
//

import Foundation

enum CoreDataError: Error {
    case saveError(Error)
    case fetchError(Error)
    case deleteError(Error)
    case entityNotFound
    case unknownError
}
