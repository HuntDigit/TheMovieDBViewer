//
//  AppearanceManager.swift
//  TestForInterview
//
//  Created by Andrii Sabinin on 27.10.2025.
//

import UIKit

enum AppTheme: String {
    case light, dark
}

class AppearanceManager {

    static var shared = AppearanceManager()
    
    private var currentTheme: AppTheme
    
    private init() {
        let isDark = UITraitCollection.current.userInterfaceStyle == .dark
        currentTheme = isDark ? .dark : .light
    }
    
    func toggleTheme() {
        switch currentTheme {
        case .light:
            applyTheme(.dark)
        case .dark:
            applyTheme(.light)
        }
    }
    
    func applyTheme(_ theme: AppTheme) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        switch theme {
        case .light:
            window.overrideUserInterfaceStyle = .light
        case .dark:
            window.overrideUserInterfaceStyle = .dark
        }
        currentTheme = theme
    }
 
}
