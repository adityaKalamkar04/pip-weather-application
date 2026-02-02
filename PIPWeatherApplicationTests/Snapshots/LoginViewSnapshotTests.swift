//
//  LoginViewSnapshotTests.swift
//  PIPWeatherApplicationTests
//
//  Created by Snapshot Tests on 31/01/26.
//

import XCTest
import SwiftUI
@testable import PIPWeatherApplication

/// Snapshot tests for LoginView
/// Tests visual appearance and UI states
final class LoginViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Set to true to record new reference images
        // Set to false to compare against existing images
        SnapshotHelper.isRecording = false
    }
    
    // MARK: - Initial State Tests
    
    func testLoginViewInitialState() {
        // Given
        let view = LoginView(isLoggedIn: .constant(false))
        
        // Then - Capture snapshot
        SnapshotHelper.assertSnapshot(
            of: view,
            named: "LoginView_InitialState",
            in: self
        )
    }
    
    func testLoginViewWithEmptyFields() {
        // Given
        let view = LoginView(isLoggedIn: .constant(false))
        
        // Then - Capture snapshot
        SnapshotHelper.assertSnapshot(
            of: view,
            named: "LoginView_EmptyFields",
            in: self
        )
    }
    
    // MARK: - Different Device Sizes
    
    func testLoginViewOnIPhoneSE() {
        // Given
        let view = LoginView(isLoggedIn: .constant(false))
        
        // Then - Capture snapshot for iPhone SE
        SnapshotHelper.assertSnapshot(
            of: view,
            size: SnapshotHelper.DeviceSize.iPhoneSE.size,
            named: "LoginView_iPhone_SE",
            in: self
        )
    }
    
    func testLoginViewOnIPhone14Pro() {
        // Given
        let view = LoginView(isLoggedIn: .constant(false))
        
        // Then - Capture snapshot for iPhone 14 Pro
        SnapshotHelper.assertSnapshot(
            of: view,
            size: SnapshotHelper.DeviceSize.iPhone14Pro.size,
            named: "LoginView_iPhone_14_Pro",
            in: self
        )
    }
    
    func testLoginViewOnIPhone14ProMax() {
        // Given
        let view = LoginView(isLoggedIn: .constant(false))
        
        // Then - Capture snapshot for iPhone 14 Pro Max
        SnapshotHelper.assertSnapshot(
            of: view,
            size: SnapshotHelper.DeviceSize.iPhone14ProMax.size,
            named: "LoginView_iPhone_14_Pro_Max",
            in: self
        )
    }
    
    // MARK: - Color Scheme Tests
    
    func testLoginViewLightMode() {
        // Given
        let view = LoginView(isLoggedIn: .constant(false))
            .preferredColorScheme(.light)
        
        // Then - Capture snapshot
        SnapshotHelper.assertSnapshot(
            of: view,
            named: "LoginView_LightMode",
            in: self
        )
    }
    
    func testLoginViewDarkMode() {
        // Given
        let view = LoginView(isLoggedIn: .constant(false))
            .preferredColorScheme(.dark)
        
        // Then - Capture snapshot
        SnapshotHelper.assertSnapshot(
            of: view,
            named: "LoginView_DarkMode",
            in: self
        )
    }
}
