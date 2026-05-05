//
//  SRIAppearance.swift
//  SriMovil
//
//  Created by usradmin on 5/5/26.
//

import SwiftUI

enum SRIAppearance {
    
    static func configure() {
        configureSegmentedControl()
    }
    
    private static func configureSegmentedControl() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(SRIColors.primary)
        
        UISegmentedControl.appearance().setTitleTextAttributes(
            [
                .foregroundColor: UIColor.label,
                .font: UIFont.systemFont(ofSize: 15, weight: .semibold)
            ],
            for: .normal
        )
        
        UISegmentedControl.appearance().setTitleTextAttributes(
            [
                .foregroundColor: UIColor.white,
                .font: UIFont.systemFont(ofSize: 15, weight: .semibold)
            ],
            for: .selected
        )
    }
}
