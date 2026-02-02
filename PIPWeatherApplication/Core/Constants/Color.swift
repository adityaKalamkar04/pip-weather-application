//
//  Color.swift
//  PIPWeatherApplication
//
//  Created by a.unmesh.kalamkar on 27/01/26.
//

import SwiftUI

extension Color {
    // MARK: - Green Tag Primary Colors
    static let greenTagPrimary = Color(red: 0.42, green: 0.55, blue: 0.22) // Olive green for buttons
    static let greenTagLight = Color(red: 0.88, green: 0.95, blue: 0.82) // Light green background
    static let greenTagDark = Color(red: 0.32, green: 0.42, blue: 0.16) // Dark green accents
    static let greenTagNotification = Color(red: 0.48, green: 0.62, blue: 0.26) // Notification green
    
    // MARK: - Background Colors
    static let backgroundLight = Color(red: 0.88, green: 0.95, blue: 0.82) // Light green tint
    static let backgroundDark = Color(red: 0.11, green: 0.11, blue: 0.12)
    static let cardBackground = Color.white
    static let cardBackgroundDark = Color(red: 0.17, green: 0.17, blue: 0.18)
    
    // MARK: - Text Colors
    static let textPrimary = Color(red: 0.15, green: 0.15, blue: 0.15)
    static let textSecondary = Color(red: 0.5, green: 0.5, blue: 0.5)
    static let textTertiary = Color(red: 0.7, green: 0.7, blue: 0.7)
    static let textWhite = Color.white
    
    // MARK: - Button Colors
    static let buttonPrimary = Color(red: 0.42, green: 0.55, blue: 0.22)
    static let buttonSecondary = Color(red: 0.8, green: 0.8, blue: 0.8, opacity: 0.5)
    static let buttonDisabled = Color.gray.opacity(0.3)
    
    // MARK: - Tab Bar Colors
    static let tabBarBackground = Color.white
    static let tabBarBackgroundDark = Color(red: 0.17, green: 0.17, blue: 0.18)
    static let tabBarSelected = Color(red: 0.42, green: 0.55, blue: 0.22)
    static let tabBarUnselected = Color.gray
    
    // MARK: - Border Colors
    static let borderLight = Color(red: 0.9, green: 0.9, blue: 0.9)
    static let borderGreen = Color(red: 0.42, green: 0.55, blue: 0.22)
    
    // MARK: - Notification Colors
    static let notificationGreen = Color(red: 0.48, green: 0.62, blue: 0.26)
    static let notificationDarkGreen = Color(red: 0.38, green: 0.50, blue: 0.20)
    
    // MARK: - Weather Icon Colors
    static let weatherSun = Color(red: 0.95, green: 0.77, blue: 0.06)
    static let weatherCloud = Color(red: 0.6, green: 0.6, blue: 0.6)
    static let weatherPartlyCloud = Color(red: 0.7, green: 0.7, blue: 0.7)
}
