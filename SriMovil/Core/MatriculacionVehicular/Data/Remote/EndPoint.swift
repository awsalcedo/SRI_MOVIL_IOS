//
//  EndPoint.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import Foundation

struct EndPoint {
    let baseURL: String
    let context: String
    let path: String
    let method: HTTPMethod
    
    var url: URL? {
        return URL(string: baseURL + context + path)
    }
}
