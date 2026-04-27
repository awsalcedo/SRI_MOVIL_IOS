//
//  SectionBlock.swift
//  SriMovil
//
//  Created by ALEX WLADIMIR SALCEDO SILVA on 17/4/26.
//

import SwiftUI

struct SectionBlock<Content: View>: View {
    
    let title: String
    let content: Content
    
    init(
        title: String,
        @ViewBuilder content: () -> Content
    ) {
        self.title = title
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(title)
                .font(.title3.weight(.semibold))
                .padding(.horizontal, SRISpacing.large)
            
            content
        }
    }
}
