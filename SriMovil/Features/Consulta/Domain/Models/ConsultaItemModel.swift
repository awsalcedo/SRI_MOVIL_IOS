//
//  ConsultaItemModel.swift
//  SriMovil
//
//  Created by usradmin on 4/6/26.
//

import Foundation

struct ConsultaItemModel: Identifiable, Equatable, Sendable {
    let id: String
    let title: String
    let icon: String
    let type: ConsultaType
    let isCentered: Bool

    var hasIcon: Bool {
        !icon.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
