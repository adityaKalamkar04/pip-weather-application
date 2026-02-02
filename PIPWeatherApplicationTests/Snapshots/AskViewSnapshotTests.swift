//
//  AskViewSnapshotTests.swift
//  PIPWeatherApplicationTests
//
//  Created by Snapshot Tests on 31/01/26.
//

import XCTest
import SwiftUI
@testable import PIPWeatherApplication

/// Snapshot tests for AskView
/// Tests visual appearance and question interface
final class AskViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Set to true to record new reference images
        // Set to false to compare against existing images
        SnapshotHelper.isRecording = false
    }
    
    // MARK: - Initial State Tests
    
    func testAskViewInitialState() {
        // Given
        let view = AskView()
        
        // Then - Capture snapshot
        SnapshotHelper.assertSnapshot(
            of: view,
            named: "AskView_InitialState",
            in: self
        )
    }
    
    // MARK: - Different Device Sizes
    
    func testAskViewOnIPhoneSE() {
        // Given
        let view = AskView()
        
        // Then - Capture snapshot for iPhone SE
        SnapshotHelper.assertSnapshot(
            of: view,
            size: SnapshotHelper.DeviceSize.iPhoneSE.size,
            named: "AskView_iPhone_SE",
            in: self
        )
    }
    
    func testAskViewOnIPhone14Pro() {
        // Given
        let view = AskView()
        
        // Then - Capture snapshot for iPhone 14 Pro
        SnapshotHelper.assertSnapshot(
            of: view,
            size: SnapshotHelper.DeviceSize.iPhone14Pro.size,
            named: "AskView_iPhone_14_Pro",
            in: self
        )
    }
    
    func testAskViewOnIPad() {
        // Given
        let view = AskView()
        
        // Then - Capture snapshot for iPad Pro 11"
        SnapshotHelper.assertSnapshot(
            of: view,
            size: SnapshotHelper.DeviceSize.iPadPro11.size,
            named: "AskView_iPad_Pro_11",
            in: self
        )
    }
    
    // MARK: - Color Scheme Tests
    
    func testAskViewLightMode() {
        // Given
        let view = AskView()
            .preferredColorScheme(.light)
        
        // Then - Capture snapshot
        SnapshotHelper.assertSnapshot(
            of: view,
            named: "AskView_LightMode",
            in: self
        )
    }
    
    func testAskViewDarkMode() {
        // Given
        let view = AskView()
            .preferredColorScheme(.dark)
        
        // Then - Capture snapshot
        SnapshotHelper.assertSnapshot(
            of: view,
            named: "AskView_DarkMode",
            in: self
        )
    }
}
