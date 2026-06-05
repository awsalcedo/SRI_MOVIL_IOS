//
//  SriMovilApp.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 31/7/24.
//

import SwiftUI
import FirebaseCore

@main
struct SriMovilApp: App {
    
    init() {
        FirebaseApp.configure()
        SRIAppearance.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            //SriTabView()
            ConsultasLegadaView()
        }
    }
}
