//
//  ConsultasLocalDataSource.swift
//  SriMovil
//
//  Created by usradmin on 4/6/26.
//

import Foundation

final class ConsultasLocalDataSource: ConsultasLocalDataSourceProtocol {
    
    private let bundle: Bundle
    private let fileName: String
    
    init(bundle: Bundle = .main, fileName: String = "consultas") {
        self.bundle = bundle
        self.fileName = fileName
    }
    
    func getConsultas() throws -> [ConsultaItemDto] {
        guard let url = bundle.url(forResource: fileName, withExtension: "json") else {
            throw ConsultasDataError.fileNotFound(fileName: "\(fileName).json")
        }
        
        do {
            let data = try Data(contentsOf: url)
            return try JSONDecoder().decode([ConsultaItemDto].self, from: data)
        } catch let error as DecodingError {
            throw ConsultasDataError.decodingFailed
        } catch {
            throw ConsultasDataError.readFailed
        }
    }
}

enum ConsultasDataError: Error, Sendable {
    case fileNotFound(fileName: String)
    case readFailed
    case decodingFailed
}
