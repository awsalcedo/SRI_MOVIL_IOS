//
//  ConsultaItem.swift
//  SriMovil
//
//  Created by usradmin on 3/6/26.
//

import Foundation

struct ConsultaItemDto: Decodable {
    let id: String
    let title: String
    let icon: String
    let type: String
    let isCentered: Bool?
}
