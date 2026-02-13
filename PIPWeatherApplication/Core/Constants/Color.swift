//
//  Color.swift
//  PIPWeatherApplication
//
//  Created by a.unmesh.kalamkar on 27/01/26.
//

import SwiftUI

extension Color {
    // MARK: - Weather App Primary Colors (Adaptive)
    static let greenTagPrimary = Color("GreenTagPrimary", bundle: nil, fallback: Color(red: 0.42, green: 0.55, blue: 0.22))
    static let greenTagLight = Color("GreenTagLight", bundle: nil, fallback: Color(red: 0.88, green: 0.95, blue: 0.82))
    static let greenTagDark = Color("GreenTagDark", bundle: nil, fallback: Color(red: 0.32, green: 0.42, blue: 0.16))
    static let greenTagNotification = Color("GreenTagNotification", bundle: nil, fallback: Color(red: 0.48, green: 0.62, blue: 0.26))
    
    // MARK: - Adaptive Background Colors
    static var backgroundLight: Color {
        Color("BackgroundLight", bundle: nil, fallback: adaptiveColor(
            light: Color(red: 0.88, green: 0.95, blue: 0.82),
            dark: Color(red: 0.11, green: 0.11, blue: 0.12)
        ))
    }
    
    static var cardBackground: Color {
        Color("CardBackground", bundle: nil, fallback: adaptiveColor(
            light: Color.white,
            dark: Color(red: 0.17, green: 0.17, blue: 0.18)
        ))
    }
    
    // MARK: - Adaptive Text Colors
    static var textPrimary: Color {
        Color("TextPrimary", bundle: nil, fallback: adaptiveColor(
            light: Color(red: 0.15, green: 0.15, blue: 0.15),
            dark: Color(red: 0.95, green: 0.95, blue: 0.95)
        ))
    }
    
    static var textSecondary: Color {
        Color("TextSecondary", bundle: nil, fallback: adaptiveColor(
            light: Color(red: 0.5, green: 0.5, blue: 0.5),
            dark: Color(red: 0.7, green: 0.7, blue: 0.7)
        ))
    }
    
    static var textTertiary: Color {
        Color("TextTertiary", bundle: nil, fallback: adaptiveColor(
            light: Color(red: 0.7, green: 0.7, blue: 0.7),
            dark: Color(red: 0.5, green: 0.5, blue: 0.5)
        ))
    }
    
    static let textWhite = Color.white
    
    // MARK: - Button Colors
    static let buttonPrimary = Color(red: 0.42, green: 0.55, blue: 0.22)
    static let buttonSecondary = Color(red: 0.8, green: 0.8, blue: 0.8, opacity: 0.5)
    static let buttonDisabled = Color.gray.opacity(0.3)
    
    // MARK: - Adaptive Tab Bar Colors
    static var tabBarBackground: Color {
        Color("TabBarBackground", bundle: nil, fallback: adaptiveColor(
            light: Color.white,
            dark: Color(red: 0.17, green: 0.17, blue: 0.18)
        ))
    }
    
    static let tabBarSelected = Color(red: 0.42, green: 0.55, blue: 0.22)
    
    static var tabBarUnselected: Color {
        adaptiveColor(
            light: Color.gray,
            dark: Color(red: 0.6, green: 0.6, blue: 0.6)
        )
    }
    
    // MARK: - Adaptive Border Colors
    static var borderLight: Color {
        Color("BorderLight", bundle: nil, fallback: adaptiveColor(
            light: Color(red: 0.9, green: 0.9, blue: 0.9),
            dark: Color(red: 0.3, green: 0.3, blue: 0.3)
        ))
    }
    
    static let borderGreen = Color(red: 0.42, green: 0.55, blue: 0.22)
    
    // MARK: - Notification Colors
    static let notificationGreen = Color(red: 0.48, green: 0.62, blue: 0.26)
    static let notificationDarkGreen = Color(red: 0.38, green: 0.50, blue: 0.20)
    
    // MARK: - Weather Icon Colors
    static let weatherSun = Color(red: 0.95, green: 0.77, blue: 0.06)
    static let weatherCloud = Color(red: 0.6, green: 0.6, blue: 0.6)
    static let weatherPartlyCloud = Color(red: 0.7, green: 0.7, blue: 0.7)
    
    // MARK: - Helper Method for Adaptive Colors
    private static func adaptiveColor(light: Color, dark: Color) -> Color {
        return Color(UIColor { traitCollection in
            switch traitCollection.userInterfaceStyle {
            case .dark:
                return UIColor(dark)
            default:
                return UIColor(light)
            }
        })
    }
}

// MARK: - Custom Color Initializer with Fallback
extension Color {
    init(_ name: String, bundle: Bundle?, fallback: Color) {
        if let color = UIColor(named: name, in: bundle, compatibleWith: nil) {
            self.init(uiColor: color)
        } else {
            self = fallback
        }
    }
}
