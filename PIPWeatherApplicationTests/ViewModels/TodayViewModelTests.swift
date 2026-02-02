//
//  TodayViewModelTests.swift
//  PIPWeatherApplicationTests
//
//  Created by Unit Tests on 01/02/26.
//

import Testing
import Foundation
import Combine
@testable import PIPWeatherApplication

/// Test suite for TodayViewModel
/// Tests the main functionality of loading today's data including items, weather, and user information
@Suite("TodayViewModel Tests")
struct TodayViewModelTests {
    
    // MARK: - Test Load Today Success
    
    @Test("Load today data successfully")
    func testLoadTodaySuccess() async throws {
        // Given
        let viewModel = TodayViewModel()
        
        // When
        viewModel.loadToday()
        
        // Then - Verify data is loaded
        #expect(!viewModel.todayItems.isEmpty, "Today items should not be empty after successful load")
        #expect(viewModel.weatherForecast != nil, "Weather forecast should be loaded")
        #expect(viewModel.user != nil, "User should be loaded")
        #expect(!viewModel.dateDisplay.isEmpty, "Date display should not be empty")
        #expect(viewModel.isLoading == false, "Loading should be false after completion")
        #expect(viewModel.errorMessage == nil, "Error message should be nil on success")
    }
    
    @Test("Today items populated correctly")
    func testTodayItemsPopulated() async throws {
        // Given
        let viewModel = TodayViewModel()
        
        // When
        viewModel.loadToday()
        
        // Then - Verify items structure
        #expect(viewModel.todayItems.count > 0, "Should have at least one today item")
        
        // Check that items have valid IDs and titles
        for item in viewModel.todayItems {
            #expect(!item.id.isEmpty, "Item ID should not be empty")
            #expect(!item.title.isEmpty, "Item title should not be empty")
        }
    }
    
    @Test("Weather forecast populated correctly")
    func testWeatherForecastPopulated() async throws {
        // Given
        let viewModel = TodayViewModel()
        
        // When
        viewModel.loadToday()
        
        // Then - Verify weather forecast structure
        #expect(viewModel.weatherForecast != nil, "Weather forecast should be loaded")
        
        if let forecast = viewModel.weatherForecast {
            #expect(!forecast.days.isEmpty, "Weather forecast should have days")
            
            // Verify each day has valid data
            for day in forecast.days {
                #expect(!day.day.isEmpty, "Day name should not be empty")
                #expect(!day.temperature.isEmpty, "Temperature should not be empty")
            }
        }
    }
    
    @Test("User information loaded correctly")
    func testUserInformationLoaded() async throws {
        // Given
        let viewModel = TodayViewModel()
        
        // When
        viewModel.loadToday()
        
        // Then - Verify user data
        #expect(viewModel.user != nil, "User should be loaded")
        
        if let user = viewModel.user {
            #expect(!user.name.isEmpty, "User name should not be empty")
            #expect(!user.greeting.isEmpty, "User greeting should not be empty")
        }
    }
    
    @Test("Date display formatted correctly")
    func testDateDisplayFormatted() async throws {
        // Given
        let viewModel = TodayViewModel()
        
        // When
        viewModel.loadToday()
        
        // Then - Verify date is formatted
        #expect(!viewModel.dateDisplay.isEmpty, "Date display should not be empty")
        #expect(viewModel.dateDisplay != "May 8", "Date should be updated from default value")
    }
    
    // MARK: - Test Loading State
    
    @Test("Loading state changes correctly")
    func testLoadingStateChanges() async throws {
        // Given
        let viewModel = TodayViewModel()
        
        // Initial state
        #expect(viewModel.isLoading == false, "Loading should be false initially")
        
        // When - Load data
        viewModel.loadToday()
        
        // Then - Loading should be false after completion
        #expect(viewModel.isLoading == false, "Loading should be false after data loads")
    }
    
    @Test("Error message cleared on successful load")
    func testErrorMessageClearedOnSuccess() async throws {
        // Given
        let viewModel = TodayViewModel()
        viewModel.errorMessage = "Previous error"
        
        // When
        viewModel.loadToday()
        
        // Then
        #expect(viewModel.errorMessage == nil, "Error message should be cleared on successful load")
    }
    
    // MARK: - Test Item Types
    
    @Test("Notification items identified correctly")
    func testNotificationItemsIdentified() async throws {
        // Given
        let viewModel = TodayViewModel()
        
        // When
        viewModel.loadToday()
        
        // Then - Check if notification items are properly identified
        let notificationItems = viewModel.todayItems.filter { $0.isNotification }
        
        for item in notificationItems {
            #expect(item.type.lowercased() == "notification", "Notification items should have correct type")
        }
    }
    
    @Test("Project items identified correctly")
    func testProjectItemsIdentified() async throws {
        // Given
        let viewModel = TodayViewModel()
        
        // When
        viewModel.loadToday()
        
        // Then - Check if project items are properly identified
        let projectItems = viewModel.todayItems.filter { $0.isProject }
        
        for item in projectItems {
            #expect(item.type.lowercased() == "project", "Project items should have correct type")
        }
    }
    
    @Test("Urgent items flagged correctly")
    func testUrgentItemsFlagged() async throws {
        // Given
        let viewModel = TodayViewModel()
        
        // When
        viewModel.loadToday()
        
        // Then - Verify urgent items have proper urgency hints
        let urgentItems = viewModel.todayItems.filter { $0.isUrgent }
        
        for item in urgentItems {
            let hint = item.urgencyHint?.lowercased() ?? ""
            #expect(hint == "high" || hint == "urgent", "Urgent items should have high or urgent hint")
        }
    }
    
    // MARK: - Test Multiple Loads
    
    @Test("Multiple loads update data correctly")
    func testMultipleLoads() async throws {
        // Given
        let viewModel = TodayViewModel()
        
        // When - Load multiple times
        viewModel.loadToday()
        let firstLoadCount = viewModel.todayItems.count
        
        viewModel.loadToday()
        let secondLoadCount = viewModel.todayItems.count
        
        // Then - Data should be consistent
        #expect(firstLoadCount == secondLoadCount, "Multiple loads should return same data count")
        #expect(viewModel.errorMessage == nil, "Should not have errors after multiple loads")
    }
    
    // MARK: - Test Data Integrity
    
    @Test("All required fields present in today items")
    func testAllRequiredFieldsPresent() async throws {
        // Given
        let viewModel = TodayViewModel()
        
        // When
        viewModel.loadToday()
        
        // Then - Check all items have required fields
        for item in viewModel.todayItems {
            #expect(!item.id.isEmpty, "Item must have ID")
            #expect(!item.type.isEmpty, "Item must have type")
            #expect(!item.title.isEmpty, "Item must have title")
        }
    }
    
    @Test("Weather forecast days have valid data")
    func testWeatherForecastDaysValid() async throws {
        // Given
        let viewModel = TodayViewModel()
        
        // When
        viewModel.loadToday()
        
        // Then
        if let forecast = viewModel.weatherForecast {
            #expect(forecast.days.count > 0, "Should have at least one weather day")
            
            for day in forecast.days {
                #expect(!day.id.isEmpty, "Weather day must have ID")
                #expect(!day.day.isEmpty, "Weather day must have day name")
                #expect(!day.temperature.isEmpty, "Weather day must have temperature")
                #expect(!day.unit.isEmpty, "Weather day must have unit")
            }
        }
    }
}
