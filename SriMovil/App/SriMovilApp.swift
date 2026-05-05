//
//  SriMovilApp.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI

@main
struct SriMovilApp: App {
    
    init() {
        SRIAppearance.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            SriTabView()
        }
    }
}
