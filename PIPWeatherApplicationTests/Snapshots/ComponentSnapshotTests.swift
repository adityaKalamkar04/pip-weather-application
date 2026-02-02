//
//  ComponentSnapshotTests.swift
//  PIPWeatherApplicationTests
//
//  Created by Snapshot Tests on 31/01/26.
//

import XCTest
import SwiftUI
@testable import PIPWeatherApplication

/// Snapshot tests for individual UI components
/// Tests reusable components and widgets
final class ComponentSnapshotTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Set to true to record new reference images
        // Set to false to compare against existing images
        SnapshotHelper.isRecording = false
    }
    
    // MARK: - CustomTabBar Tests
    
    func testCustomTabBarTodaySelected() {
        // Given
        let view = CustomTabBar(selectedTab: .constant(.today))
        
        // Then - Capture snapshot
        SnapshotHelper.assertSnapshot(
            of: view,
            size: CGSize(width: 390, height: 100),
            named: "CustomTabBar_TodaySelected",
            in: self
        )
    }
    
    func testCustomTabBarProjectsSelected() {
        // Given
        let view = CustomTabBar(selectedTab: .constant(.projects))
        
        // Then - Capture snapshot
        SnapshotHelper.assertSnapshot(
            of: view,
            size: CGSize(width: 390, height: 100),
            named: "CustomTabBar_ProjectsSelected",
            in: self
        )
    }
    
    func testCustomTabBarTakePhotoSelected() {
        // Given
        let view = CustomTabBar(selectedTab: .constant(.takePhoto))
        
        // Then - Capture snapshot
        SnapshotHelper.assertSnapshot(
            of: view,
            size: CGSize(width: 390, height: 100),
            named: "CustomTabBar_TakePhotoSelected",
            in: self
        )
    }
    
    func testCustomTabBarAskSelected() {
        // Given
        let view = CustomTabBar(selectedTab: .constant(.ask))
        
        // Then - Capture snapshot
        SnapshotHelper.assertSnapshot(
            of: view,
            size: CGSize(width: 390, height: 100),
            named: "CustomTabBar_AskSelected",
            in: self
        )
    }
    
    // MARK: - NotificationDetailView Tests
    
    func testNotificationDetailViewNormal() {
        // Given
        let notification = AppNotification(
            id: "test1",
            title: "Test Notification",
            message: "This is a test notification message for snapshot testing.",
            time: "10:30 AM",
            isUrgent: false,
            icon: "bell.fill"
        )
        let view = NotificationDetailView(notification: notification)
        
        // Then - Capture snapshot
        SnapshotHelper.assertSnapshot(
            of: view,
            size: CGSize(width: 390, height: 600),
            named: "NotificationDetailView_Normal",
            in: self
        )
    }
    
    func testNotificationDetailViewUrgent() {
        // Given
        let notification = AppNotification(
            id: "test2",
            title: "Urgent Notification",
            message: "This is an urgent notification that requires immediate attention.",
            time: "Just now",
            isUrgent: true,
            icon: "exclamationmark.triangle.fill"
        )
        let view = NotificationDetailView(notification: notification)
        
        // Then - Capture snapshot
        SnapshotHelper.assertSnapshot(
            of: view,
            size: CGSize(width: 390, height: 600),
            named: "NotificationDetailView_Urgent",
            in: self
        )
    }
    
    // MARK: - ForgotPasswordView Tests
    
    func testForgotPasswordViewInitial() {
        // Given
        let view = ForgotPasswordView()
        
        // Then - Capture snapshot
        SnapshotHelper.assertSnapshot(
            of: view,
            size: SnapshotHelper.DeviceSize.iPhone14Pro.size,
            named: "ForgotPasswordView_Initial",
            in: self
        )
    }
    
    // MARK: - Color Mode Tests
    
    func testCustomTabBarLightMode() {
        // Given
        let view = CustomTabBar(selectedTab: .constant(.today))
            .preferredColorScheme(.light)
        
        // Then - Capture snapshot
        SnapshotHelper.assertSnapshot(
            of: view,
            size: CGSize(width: 390, height: 100),
            named: "CustomTabBar_LightMode",
            in: self
        )
    }
    
    func testCustomTabBarDarkMode() {
        // Given
        let view = CustomTabBar(selectedTab: .constant(.today))
            .preferredColorScheme(.dark)
        
        // Then - Capture snapshot
        SnapshotHelper.assertSnapshot(
            of: view,
            size: CGSize(width: 390, height: 100),
            named: "CustomTabBar_DarkMode",
            in: self
        )
    }
}
