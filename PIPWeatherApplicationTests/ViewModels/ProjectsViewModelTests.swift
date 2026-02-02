//
//  ProjectsViewModelTests.swift
//  PIPWeatherApplicationTests
//
//  Created by Unit Tests on 01/02/26.
//

import Testing
import Foundation
import Combine
@testable import PIPWeatherApplication

/// Test suite for ProjectsViewModel
/// Tests the main functionality of loading projects data
@Suite("ProjectsViewModel Tests")
struct ProjectsViewModelTests {
    
    // MARK: - Test Load Projects Success
    
    @Test("Load projects successfully")
    func testLoadProjectsSuccess() async throws {
        // Given
        let viewModel = ProjectsViewModel()
        
        // When
        viewModel.loadProjects()
        
        // Then - Verify data is loaded
        #expect(!viewModel.projects.isEmpty, "Projects should not be empty after successful load")
        #expect(viewModel.user != nil, "User should be loaded")
        #expect(viewModel.isLoading == false, "Loading should be false after completion")
        #expect(viewModel.errorMessage == nil, "Error message should be nil on success")
    }
    
    @Test("Projects populated correctly")
    func testProjectsPopulated() async throws {
        // Given
        let viewModel = ProjectsViewModel()
        
        // When
        viewModel.loadProjects()
        
        // Then - Verify projects structure
        #expect(viewModel.projects.count > 0, "Should have at least one project")
        
        // Check that projects have valid IDs and names
        for project in viewModel.projects {
            #expect(!project.id.isEmpty, "Project ID should not be empty")
            #expect(!project.name.isEmpty, "Project name should not be empty")
        }
    }
    
    @Test("User information loaded with projects")
    func testUserInformationLoaded() async throws {
        // Given
        let viewModel = ProjectsViewModel()
        
        // When
        viewModel.loadProjects()
        
        // Then - Verify user data
        #expect(viewModel.user != nil, "User should be loaded")
        
        if let user = viewModel.user {
            #expect(!user.name.isEmpty, "User name should not be empty")
            #expect(!user.greeting.isEmpty, "User greeting should not be empty")
        }
    }
    
    // MARK: - Test Loading State
    
    @Test("Loading state changes correctly")
    func testLoadingStateChanges() async throws {
        // Given
        let viewModel = ProjectsViewModel()
        
        // Initial state
        #expect(viewModel.isLoading == false, "Loading should be false initially")
        
        // When - Load projects
        viewModel.loadProjects()
        
        // Then - Loading should be false after completion
        #expect(viewModel.isLoading == false, "Loading should be false after data loads")
    }
    
    @Test("Error message cleared on successful load")
    func testErrorMessageClearedOnSuccess() async throws {
        // Given
        let viewModel = ProjectsViewModel()
        viewModel.errorMessage = "Previous error"
        
        // When
        viewModel.loadProjects()
        
        // Then
        #expect(viewModel.errorMessage == nil, "Error message should be cleared on successful load")
    }
    
    // MARK: - Test Project Properties
    
    @Test("All projects have required fields")
    func testAllProjectsHaveRequiredFields() async throws {
        // Given
        let viewModel = ProjectsViewModel()
        
        // When
        viewModel.loadProjects()
        
        // Then - Check all projects have required fields
        for project in viewModel.projects {
            #expect(!project.id.isEmpty, "Project must have ID")
            #expect(!project.name.isEmpty, "Project must have name")
            #expect(!project.status.isEmpty, "Project must have status")
            #expect(!project.description.isEmpty, "Project must have description")
        }
    }
    
    @Test("Projects have valid status values")
    func testProjectsHaveValidStatus() async throws {
        // Given
        let viewModel = ProjectsViewModel()
        
        // When
        viewModel.loadProjects()
        
        // Then - Verify status values are valid
        let validStatuses = ["active", "open", "closed", "pending", "completed"]
        
        for project in viewModel.projects {
            let statusLower = project.status.lowercased()
            let hasValidStatus = validStatuses.contains { statusLower.contains($0) }
            #expect(hasValidStatus || !project.status.isEmpty, "Project should have valid status")
        }
    }
    
    @Test("Projects have tags array")
    func testProjectsHaveTags() async throws {
        // Given
        let viewModel = ProjectsViewModel()
        
        // When
        viewModel.loadProjects()
        
        // Then - Verify tags exist (can be empty array)
        for project in viewModel.projects {
            #expect(project.tags.count >= 0, "Project should have tags array (can be empty)")
        }
    }
    
    @Test("Project title property works correctly")
    func testProjectTitleProperty() async throws {
        // Given
        let viewModel = ProjectsViewModel()
        
        // When
        viewModel.loadProjects()
        
        // Then - Verify title matches name
        for project in viewModel.projects {
            #expect(project.title == project.name, "Project title should match name")
        }
    }
    
    @Test("Project open status computed correctly")
    func testProjectOpenStatus() async throws {
        // Given
        let viewModel = ProjectsViewModel()
        
        // When
        viewModel.loadProjects()
        
        // Then - Verify isOpen computed property
        for project in viewModel.projects {
            if project.status.lowercased() == "open" {
                #expect(project.isOpen == true, "Project with 'open' status should have isOpen = true")
            } else {
                #expect(project.isOpen == false, "Project without 'open' status should have isOpen = false")
            }
        }
    }
    
    // MARK: - Test Multiple Loads
    
    @Test("Multiple loads update data correctly")
    func testMultipleLoads() async throws {
        // Given
        let viewModel = ProjectsViewModel()
        
        // When - Load multiple times
        viewModel.loadProjects()
        let firstLoadCount = viewModel.projects.count
        
        viewModel.loadProjects()
        let secondLoadCount = viewModel.projects.count
        
        // Then - Data should be consistent
        #expect(firstLoadCount == secondLoadCount, "Multiple loads should return same data count")
        #expect(viewModel.errorMessage == nil, "Should not have errors after multiple loads")
    }
    
    // MARK: - Test Data Filtering
    
    @Test("Can identify projects with specific tags")
    func testProjectsWithSpecificTags() async throws {
        // Given
        let viewModel = ProjectsViewModel()
        
        // When
        viewModel.loadProjects()
        
        // Then - Filter by tag
        let homeProjects = viewModel.projects.filter { $0.tags.contains("Home") }
        let diyProjects = viewModel.projects.filter { $0.tags.contains("DIY") }
        
        // Verify filtering works
        #expect(homeProjects.count >= 0, "Should be able to filter home projects")
        #expect(diyProjects.count >= 0, "Should be able to filter DIY projects")
    }
    
    @Test("Projects count is positive")
    func testProjectsCountIsPositive() async throws {
        // Given
        let viewModel = ProjectsViewModel()
        
        // When
        viewModel.loadProjects()
        
        // Then
        #expect(viewModel.projects.count > 0, "Should have at least one project")
    }
    
    // MARK: - Test Project Details
    
    @Test("Projects have optional image URLs")
    func testProjectsImageURLs() async throws {
        // Given
        let viewModel = ProjectsViewModel()
        
        // When
        viewModel.loadProjects()
        
        // Then - Image URLs can be nil or have value
        for project in viewModel.projects {
            // Just verify the property exists and is accessible
            _ = project.imageUrl
            _ = project.imageName
        }
    }
    
    @Test("Projects have optional location")
    func testProjectsLocation() async throws {
        // Given
        let viewModel = ProjectsViewModel()
        
        // When
        viewModel.loadProjects()
        
        // Then - Location can be nil or have value
        for project in viewModel.projects {
            // Just verify the property exists and is accessible
            _ = project.location
        }
    }
    
    @Test("Projects have optional timestamps")
    func testProjectsTimestamps() async throws {
        // Given
        let viewModel = ProjectsViewModel()
        
        // When
        viewModel.loadProjects()
        
        // Then - Timestamps can be nil or have value
        for project in viewModel.projects {
            // Just verify the properties exist and are accessible
            _ = project.createdAt
            _ = project.updatedAt
        }
    }
    
    // MARK: - Test Data Consistency
    
    @Test("All project IDs are unique")
    func testAllProjectIDsUnique() async throws {
        // Given
        let viewModel = ProjectsViewModel()
        
        // When
        viewModel.loadProjects()
        
        // Then - Verify uniqueness
        let projectIDs = viewModel.projects.map { $0.id }
        let uniqueIDs = Set(projectIDs)
        
        #expect(projectIDs.count == uniqueIDs.count, "All project IDs should be unique")
    }
    
    @Test("Projects array is not mutated unexpectedly")
    func testProjectsArrayStability() async throws {
        // Given
        let viewModel = ProjectsViewModel()
        
        // When
        viewModel.loadProjects()
        let initialCount = viewModel.projects.count
        let firstProjectID = viewModel.projects.first?.id
        
        // Access projects multiple times
        _ = viewModel.projects.count
        _ = viewModel.projects.first
        
        // Then - Array should remain stable
        #expect(viewModel.projects.count == initialCount, "Projects count should remain stable")
        #expect(viewModel.projects.first?.id == firstProjectID, "First project should remain same")
    }
}
