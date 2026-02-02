//
//  ProjectsViewSnapshotTests.swift
//  PIPWeatherApplicationTests
//
//  Created by Snapshot Tests on 01/02/26.
//

import XCTest
import SwiftUI
@testable import PIPWeatherApplication

/// Snapshot tests for ProjectsView
/// Tests visual appearance and project list display
final class ProjectsViewSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Set to true to record new reference images
        // Set to false to compare against existing images
        SnapshotHelper.isRecording = false
    }
    
    // MARK: - Initial State Tests
    
    func testProjectsViewWithData() {
        // Given
        let view = ProjectsView()
        
        // Wait for data to load
        let expectation = XCTestExpectation(description: "Wait for data load")
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 2.0)
        
        // Then - Capture snapshot
        SnapshotHelper.assertSnapshot(
            of: view,
            named: "ProjectsView_WithData",
            in: self
        )
    }
    
    // MARK: - Different Device Sizes
    
    func testProjectsViewOnIPhoneSE() {
        // Given
        let view = ProjectsView()
        
        // Then - Capture snapshot for iPhone SE
        SnapshotHelper.assertSnapshot(
            of: view,
            size: SnapshotHelper.DeviceSize.iPhoneSE.size,
            named: "ProjectsView_iPhone_SE",
            in: self
        )
    }
    
    func testProjectsViewOnIPhone14Pro() {
        // Given
        let view = ProjectsView()
        
        // Then - Capture snapshot for iPhone 14 Pro
        SnapshotHelper.assertSnapshot(
            of: view,
            size: SnapshotHelper.DeviceSize.iPhone14Pro.size,
            named: "ProjectsView_iPhone_14_Pro",
            in: self
        )
    }
    
    func testProjectsViewOnIPad() {
        // Given
        let view = ProjectsView()
        
        // Then - Capture snapshot for iPad Pro 11"
        SnapshotHelper.assertSnapshot(
            of: view,
            size: SnapshotHelper.DeviceSize.iPadPro11.size,
            named: "ProjectsView_iPad_Pro_11",
            in: self
        )
    }
    
    // MARK: - Color Scheme Tests
    
    func testProjectsViewLightMode() {
        // Given
        let view = ProjectsView()
            .preferredColorScheme(.light)
        
        // Then - Capture snapshot
        SnapshotHelper.assertSnapshot(
            of: view,
            named: "ProjectsView_LightMode",
            in: self
        )
    }
    
    func testProjectsViewDarkMode() {
        // Given
        let view = ProjectsView()
            .preferredColorScheme(.dark)
        
        // Then - Capture snapshot
        SnapshotHelper.assertSnapshot(
            of: view,
            named: "ProjectsView_DarkMode",
            in: self
        )
    }
    
    // MARK: - Component Tests
    
    func testProjectsViewHeader() {
        // Given
        let view = ProjectsView()
        
        // Then - Capture just the header portion
        SnapshotHelper.assertSnapshot(
            of: view,
            size: CGSize(width: 390, height: 250),
            named: "ProjectsView_Header",
            in: self
        )
    }
}
