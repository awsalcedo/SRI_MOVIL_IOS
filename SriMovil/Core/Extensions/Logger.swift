//
//  Logger.swift
//  SriMovil
//
//  Created by usradmin on 25/3/26.
//

import Foundation
import os

extension Logger {
    
    // MARK: - Private Properties
    
    private static let subsystem = Bundle.main.bundleIdentifier ?? "ec.gob.sri.movil.app"
    
    // MARK: - Feature Loggers
    
    /// Logger for Estado Tributario
    static let estadoTributario = Logger(subsystem: subsystem, category: "Estado Tributario")
    
    // MARK: - Log for Core Services
    
    static let core = Logger(subsystem: subsystem, category: "Core")
}
