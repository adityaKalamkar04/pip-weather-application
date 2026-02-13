//
//  AppEnvironment.swift
//  PIPWeatherApplication
//
//  Created by a.unmesh.kalamkar on 28/01/26.
//

import Foundation
import SwiftUI
import Combine

final class AppEnvironment: ObservableObject {
    // MARK: - Singleton
    static let shared = AppEnvironment()
    
    // MARK: - Published Properties
    @Published var selectedTab: TabItem = .today
    @Published var currentUser: User?
    
    // MARK: - Private Initialization
    private init() {
        setupEnvironment()
    }
    
    // MARK: - Setup
    private func setupEnvironment() {
        DeviceDetector.log("Weather App Environment initialized", type: .info)
        DeviceDetector.log("Device: \(DeviceDetector.deviceInfo)", type: .info)
        
        #if targetEnvironment(simulator)
        DeviceDetector.log("Running on Simulator", type: .warning)
        DeviceDetector.log("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━", type: .info)
        DeviceDetector.log("ℹ️  EXPECTED SIMULATOR WARNINGS (Safe to Ignore):", type: .info)
        DeviceDetector.log("   • Haptic feedback errors (CHHapticPattern)", type: .info)
        DeviceDetector.log("   • Auto Layout keyboard constraints", type: .info)
        DeviceDetector.log("   • Keyboard candidate accumulator warnings", type: .info)
        DeviceDetector.log("   These are iOS system issues, not app bugs!", type: .info)
        DeviceDetector.log("━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━", type: .info)
        #else
        DeviceDetector.log("Running on Real Device", type: .success)
        #endif
        
        // Load user info
        loadUserInfo()
    }
    
    private func loadUserInfo() {
        // Load user from UserDefaults or create default
        currentUser = User(
            name: "Aditya Kalamkar",
            greeting: "Welcome back",
            email: "a.unmesh.kalamkar@accenture.com"
        )
        DeviceDetector.log("Loaded user: \(currentUser?.name ?? "Unknown")", type: .info)
    }
}
