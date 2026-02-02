//
//  ProjectsViewModel.swift
//  PIPWeatherApplication
//
//  Created by a.unmesh.kalamkar on 29/01/26.
//

import Foundation
import Combine

final class ProjectsViewModel: ObservableObject {
    @Published var projects: [Project] = []
    @Published var user: User?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    func loadProjects() {
        isLoading = true
        errorMessage = nil
        
        let result = JSONLoader.load(ProjectsResponse.self, from: "projects")
        
        switch result {
        case .success(let response):
            self.projects = response.data.projects
            self.user = response.data.user
            self.isLoading = false
            DeviceDetector.log("Loaded \(projects.count) projects", type: .success)
            
        case .failure(let error):
            self.errorMessage = error.localizedDescription
            self.isLoading = false
            DeviceDetector.log("Failed to load projects: \(error)", type: .error)
        }
    }
}
