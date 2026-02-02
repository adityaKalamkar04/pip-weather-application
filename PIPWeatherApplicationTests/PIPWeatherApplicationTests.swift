//
//  PIPWeatherApplicationTests.swift
//  PIPWeatherApplicationTests
//
//  Created by a.unmesh.kalamkar on 23/01/26.
//

import Testing
@testable import PIPWeatherApplication
internal import CoreFoundation

/// Main test suite for PIP Weather Application
/// This suite contains integration tests and app-level tests
@Suite("PIP Weather Application Tests")
struct PIPWeatherApplicationTests {
    
    @Test("App environment initializes correctly")
    func testAppEnvironmentInitialization() async throws {
        // Given
        let appEnvironment = AppEnvironment.shared
        
        // Then
        #expect(appEnvironment.selectedTab == .today, "Default tab should be Today")
        #expect(appEnvironment.currentUser != nil, "Current user should be initialized")
    }
    
    @Test("Device detector works correctly")
    func testDeviceDetector() async throws {
        // Then - Verify device detection is working
        let isSimulator = DeviceDetector.isSimulator
        let isRealDevice = DeviceDetector.isRealDevice
        
        #expect(isSimulator != isRealDevice, "Should be either simulator or real device, not both")
        
        let deviceInfo = DeviceDetector.deviceInfo
        #expect(!deviceInfo.isEmpty, "Device info should not be empty")
    }
    
    @Test("Temperature converter converts correctly")
    func testTemperatureConverter() async throws {
        // Given
        let celsius = 25.0
        
        // When
        let celsiusDisplay = TemperatureConverter.display(celsius, unit: .celsius)
        let fahrenheitDisplay = TemperatureConverter.display(celsius, unit: .fahrenheit)
        
        // Then
        #expect(celsiusDisplay.contains("25"), "Celsius display should contain 25")
        #expect(celsiusDisplay.contains("°C"), "Celsius display should contain °C")
        #expect(fahrenheitDisplay.contains("77"), "Fahrenheit should be 77°F")
        #expect(fahrenheitDisplay.contains("°F"), "Fahrenheit display should contain °F")
    }
    
    @Test("Tab items have valid properties")
    func testTabItems() async throws {
        // Given
        let allTabs = TabItem.allCases
        
        // Then
        #expect(allTabs.count == 4, "Should have 4 tabs")
        
        for tab in allTabs {
            #expect(!tab.title.isEmpty, "Tab should have title")
            #expect(!tab.icon.isEmpty, "Tab should have icon")
            #expect(!tab.inactiveIcon.isEmpty, "Tab should have inactive icon")
        }
    }
    
    @Test("JSON loader handles valid file")
    func testJSONLoaderWithValidFile() async throws {
        // Given - today.json exists in bundle
        
        // When
        let result = JSONLoader.load(TodayResponse.self, from: "today")
        
        // Then
        switch result {
        case .success(let response):
            #expect(response.status == "success", "Response should have success status")
            #expect(!response.data.todayItems.isEmpty, "Should have today items")
        case .failure(let error):
            Issue.record("JSON loading should succeed: \(error)")
        }
    }
    
    @Test("User model has valid welcome message")
    func testUserWelcomeMessage() async throws {
        // Given
        let user = User(name: "John Doe", greeting: "Hello", email: "john@example.com")
        
        // Then
        #expect(user.welcomeMessage == "Hello, John Doe", "Welcome message should be formatted correctly")
    }
    
    @Test("App constants are properly defined")
    func testAppConstants() async throws {
        // Then - Verify constants exist and have values
        #expect(AppConstants.Layout.cornerRadius > 0, "Corner radius should be positive")
        #expect(AppConstants.Layout.padding > 0, "Padding should be positive")
    }
}

