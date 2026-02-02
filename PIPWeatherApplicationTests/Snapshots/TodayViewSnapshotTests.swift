//
//  TodayViewSnapshotTests.swift
//  PIPWeatherApplicationTests
//
//  Created by Snapshot Tests on 01/02/26.
//

import XCTest
import SwiftUI
@testable import PIPWeatherApplication

/// Snapshot tests for TodayView
/// Tests visual appearance and data display
final class TodayViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Set to true to record new reference images
        // Set to false to compare against existing images
        SnapshotHelper.isRecording = false
    }
    
    // MARK: - Initial State Tests
    
    func testTodayViewWithData() {
        // Given
        let view = TodayView()
            .onAppear {
                // View will load data automatically
            }
        
        // Wait for data to load
        let expectation = XCTestExpectation(description: "Wait for data load")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
        
        // Then - Capture snapshot
        SnapshotHelper.assertSnapshot(
            of: view,
            named: "TodayView_WithData",
            in: self
        )
    }
    
    // MARK: - Different Device Sizes
    
    func testTodayViewOnIPhoneSE() {
        // Given
        let view = TodayView()
        
        // Then - Capture snapshot for iPhone SE
        SnapshotHelper.assertSnapshot(
            of: view,
            size: SnapshotHelper.DeviceSize.iPhoneSE.size,
            named: "TodayView_iPhone_SE",
            in: self
        )
    }
    
    func testTodayViewOnIPhone14Pro() {
        // Given
        let view = TodayView()
        
        // Then - Capture snapshot for iPhone 14 Pro
        SnapshotHelper.assertSnapshot(
            of: view,
            size: SnapshotHelper.DeviceSize.iPhone14Pro.size,
            named: "TodayView_iPhone_14_Pro",
            in: self
        )
    }
    
    func testTodayViewOnIPad() {
        // Given
        let view = TodayView()
        
        // Then - Capture snapshot for iPad Pro 11"
        SnapshotHelper.assertSnapshot(
            of: view,
            size: SnapshotHelper.DeviceSize.iPadPro11.size,
            named: "TodayView_iPad_Pro_11",
            in: self
        )
    }
    
    // MARK: - Color Scheme Tests
    
    func testTodayViewLightMode() {
        // Given
        let view = TodayView()
            .preferredColorScheme(.light)
        
        // Then - Capture snapshot
        SnapshotHelper.assertSnapshot(
            of: view,
            named: "TodayView_LightMode",
            in: self
        )
    }
    
    func testTodayViewDarkMode() {
        // Given
        let view = TodayView()
            .preferredColorScheme(.dark)
        
        // Then - Capture snapshot
        SnapshotHelper.assertSnapshot(
            of: view,
            named: "TodayView_DarkMode",
            in: self
        )
    }
    
    // MARK: - Component Tests
    
    func testTodayViewHeader() {
        // Given
        let view = TodayView()
        
        // Then - Capture just the header portion
        SnapshotHelper.assertSnapshot(
            of: view,
            size: CGSize(width: 390, height: 200),
            named: "TodayView_Header",
            in: self
        )
    }
}
