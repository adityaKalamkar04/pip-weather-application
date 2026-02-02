//
//  Fonts.swift
//  PIPWeatherApplication
//
//  Created by a.unmesh.kalamkar on 30/01/26.
//

import SwiftUI

extension Font {
    // MARK: - Temperature Fonts
    static let largeTemperature = Font.system(size: 64, weight: .thin, design: .rounded)
    static let mediumTemperature = Font.system(size: 48, weight: .light, design: .rounded)
    static let smallTemperature = Font.system(size: 32, weight: .regular, design: .rounded)
    
    // MARK: - Title Fonts
    static let titleLarge = Font.system(size: 28, weight: .bold, design: .default)
    static let titleMedium = Font.system(size: 22, weight: .semibold, design: .default)
    static let titleSmall = Font.system(size: 18, weight: .semibold, design: .default)
    
    // MARK: - Body Fonts
    static let bodyLarge = Font.system(size: 17, weight: .regular, design: .default)
    static let bodyMedium = Font.system(size: 15, weight: .regular, design: .default)
    static let bodySmall = Font.system(size: 13, weight: .regular, design: .default)
    
    // MARK: - Caption Fonts
    static let captionLarge = Font.system(size: 12, weight: .medium, design: .default)
    static let captionSmall = Font.system(size: 11, weight: .regular, design: .default)
    
    // MARK: - Tab Bar Font
    static let tabBarFont = Font.system(size: 10, weight: .medium, design: .default)
    
    // MARK: - Location Font
    static let locationFont = Font.system(size: 24, weight: .semibold, design: .default)
}
