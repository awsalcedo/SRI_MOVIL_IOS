//
//  SectionBlock.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 17/4/26.
//

import SwiftUI

struct SectionBlock<Content: View, Accessory: View>: View {
    
    let title: String
    let accessory: Accessory?
    let content: Content
    
    init(
        title: String,
        @ViewBuilder accessory: () -> Accessory,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.accessory = accessory()
        self.content = content()
    }
    
    init(
        title: String,
        @ViewBuilder content: () -> Content
    ) where Accessory == EmptyView {
        self.title = title
        self.accessory = nil
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .firstTextBaseline, spacing: 6) {
                Text(title)
                    .font(.title3.weight(.semibold))
                
                if let accessory {
                    accessory
                }
            }
            .padding(.horizontal, SRISpacing.large)
            
            content
        }
    }
}
