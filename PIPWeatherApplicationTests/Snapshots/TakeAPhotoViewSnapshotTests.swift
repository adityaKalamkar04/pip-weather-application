//
//  TakeAPhotoViewSnapshotTests.swift
//  PIPWeatherApplicationTests
//
//  Created by Snapshot Tests on 01/02/26.
//

import XCTest
import SwiftUI
@testable import PIPWeatherApplication

/// Snapshot tests for TakeAPhotoView
/// Tests visual appearance and camera interface
final class TakeAPhotoViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Set to true to record new reference images
        // Set to false to compare against existing images
        SnapshotHelper.isRecording = false
    }
    
    // MARK: - Initial State Tests
    
    func testTakeAPhotoViewInitialState() {
        // Given
        let view = TakeAPhotoView()
            .environmentObject(AppEnvironment.shared)
        
        // Then - Capture snapshot
        SnapshotHelper.assertSnapshot(
            of: view,
            named: "TakeAPhotoView_InitialState",
            in: self
        )
    }
    
    // MARK: - Different Device Sizes
    
    func testTakeAPhotoViewOnIPhoneSE() {
        // Given
        let view = TakeAPhotoView()
            .environmentObject(AppEnvironment.shared)
        
        // Then - Capture snapshot for iPhone SE
        SnapshotHelper.assertSnapshot(
            of: view,
            size: SnapshotHelper.DeviceSize.iPhoneSE.size,
            named: "TakeAPhotoView_iPhone_SE",
            in: self
        )
    }
    
    func testTakeAPhotoViewOnIPhone14Pro() {
        // Given
        let view = TakeAPhotoView()
            .environmentObject(AppEnvironment.shared)
        
        // Then - Capture snapshot for iPhone 14 Pro
        SnapshotHelper.assertSnapshot(
            of: view,
            size: SnapshotHelper.DeviceSize.iPhone14Pro.size,
            named: "TakeAPhotoView_iPhone_14_Pro",
            in: self
        )
    }
    
    // MARK: - Simulator Alert Tests
    
    func testTakeAPhotoViewSimulatorAlert() {
        // Given - On simulator, alert should appear
        let view = TakeAPhotoView()
            .environmentObject(AppEnvironment.shared)
        
        // Wait for alert to appear
        let expectation = XCTestExpectation(description: "Wait for alert")
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
        
        // Then - Capture snapshot with alert
        SnapshotHelper.assertSnapshot(
            of: view,
            named: "TakeAPhotoView_SimulatorAlert",
            in: self
        )
    }
}
