//
//  ProjectsView.swift
//  PIPWeatherApplication
//
//  Created by a.unmesh.kalamkar on 27/01/26.
//

import SwiftUI

struct ProjectsView: View {
    @StateObject private var viewModel = ProjectsViewModel()
    @State private var selectedFilter: ProjectFilter = .all
    
    enum ProjectFilter: String, CaseIterable {
        case all = "All"
        case home = "Home"
        case diy = "DIY"
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                // Header
                headerView
                
                // Projects title and add button
                HStack {
                    Text("Projects")
                        .font(.system(size: 34, weight: .bold))
                        .foregroundColor(.textPrimary)
                    
                    Spacer()
                    
                    Button(action: {
                        // Add project action
                    }) {
                        Image(systemName: "plus")
                            .font(.system(size: 24))
                            .foregroundColor(.textPrimary)
                            .frame(width: 44, height: 44)
                            .background(Color.white)
                            .clipShape(Circle())
                            .shadow(color: .black.opacity(0.1), radius: 4, x: 0, y: 2)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 16)
                .padding(.bottom, 20)
                
                // Featured project
                if let featuredProject = viewModel.projects.first {
                    FeaturedProjectCard(project: featuredProject)
                        .padding(.horizontal)
                        .padding(.bottom, 16)
                }
                
                // Filter tabs
                filterTabsView
                    .padding(.bottom, 16)
                
                // Projects list
                ScrollView {
                    LazyVStack(spacing: 12) {
                        ForEach(filteredProjects) { project in
                            ProjectRowCard(project: project)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.bottom, 20)
                }
            }
            .navigationBarHidden(true)
        }
        }
        .onAppear {
            viewModel.loadProjects()
        }
    }
    
    // MARK: - Subviews
    
    private var headerView: some View {
        HStack {
            // User avatar
            Image(systemName: "person.circle.fill")
                .font(.system(size: 40))
                .foregroundColor(.greenTagPrimary)
            
            VStack(alignment: .leading, spacing: 2) {
                Text(viewModel.user?.greeting ?? "Welcome back")
                    .font(.system(size: 13))
                    .foregroundColor(.textSecondary)
                
                Text(viewModel.user?.name ?? "User")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.textPrimary)
            }
            
            Spacer()
            
            // Notification bell
            NavigationLink(destination: NotificationDetailView(notification: getDefaultNotification())) {
                ZStack(alignment: .topTrailing) {
                    Image(systemName: "bell")
                        .font(.system(size: 22))
                        .foregroundColor(.textPrimary)
                    
                    // Notification badge
                    Circle()
                        .fill(Color.greenTagNotification)
                        .frame(width: 8, height: 8)
                        .offset(x: 4, y: -4)
                }
                .frame(width: 44, height: 44)
            }
            
            // Search button
            Button(action: {
                // Search action
            }) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 22))
                    .foregroundColor(.textPrimary)
                    .frame(width: 44, height: 44)
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
    
    private var filterTabsView: some View {
        HStack(spacing: 0) {
            ForEach(ProjectFilter.allCases, id: \.self) { filter in
                Button(action: {
                    withAnimation {
                        selectedFilter = filter
                    }
                }) {
                    VStack(spacing: 8) {
                        Text(filter.rawValue)
                            .font(.system(size: 16, weight: selectedFilter == filter ? .semibold : .regular))
                            .foregroundColor(selectedFilter == filter ? .greenTagPrimary : .textSecondary)
                        
                        Rectangle()
                            .fill(selectedFilter == filter ? Color.greenTagPrimary : Color.clear)
                            .frame(height: 3)
                    }
                }
                .frame(maxWidth: .infinity)
            }
        }
        .padding(.horizontal)
    }
    
    private var filteredProjects: [Project] {
        guard selectedFilter != .all else { return Array(viewModel.projects.dropFirst()) }
        
        return viewModel.projects.dropFirst().filter { project in
            project.tags.contains(selectedFilter.rawValue)
        }
    }
    
    private func getDefaultNotification() -> AppNotification {
        return AppNotification(
            id: "default",
            title: "Project Update",
            message: "Stay updated on all your project activities and notifications.",
            time: "Now",
            isUrgent: false,
            icon: "bell.fill"
        )
    }
}

// MARK: - Featured Project Card
struct FeaturedProjectCard: View {
    let project: Project
    
    var body: some View {
        NavigationLink(destination: ProjectDetailView(project: project)) {
            ZStack(alignment: .bottomLeading) {
                // Background image
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 220)
                    .cornerRadius(16)
                    .overlay(
                        Image("driveway_project")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(height: 220)
                            .clipped()
                            .cornerRadius(16)
                    )
                
                VStack(alignment: .leading) {
                    Spacer()
                    
                    Text(project.name)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
                    
                    HStack {
                        Text("Open")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                        
                        Spacer()
                        
                        Image(systemName: "arrow.right")
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .padding(.horizontal, 16)
                    .background(Color.white.opacity(0.3))
                    .cornerRadius(12)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.white.opacity(0.5), lineWidth: 1)
                    )
                    .padding(.top, 8)
                }
                .padding(20)
            }
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Project Row Card
struct ProjectRowCard: View {
    let project: Project
    
    var body: some View {
        NavigationLink(destination: ProjectDetailView(project: project)) {
            HStack(spacing: 12) {
                // Project image
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(width: 100, height: 100)
                    .cornerRadius(12)
                    .overlay(
                        Image(project.imageName ?? "")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 100, height: 100)
                            .clipped()
                            .cornerRadius(12)
                    )
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(project.name)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.textPrimary)
                    
                    Spacer()
                    
                    HStack {
                        Text("Open")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(.textPrimary)
                        
                        Spacer()
                        
                        Image(systemName: "arrow.right")
                            .font(.system(size: 12))
                            .foregroundColor(.textSecondary)
                    }
                    .frame(maxWidth: .infinity)
                    .frame(height: 36)
                    .padding(.horizontal, 12)
                    .background(Color.white)
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.borderLight, lineWidth: 1)
                    )
                }
                .frame(maxWidth: .infinity)
            }
            .frame(height: 100)
            .padding(8)
            .background(Color.white)
            .cornerRadius(12)
            .shadow(color: .black.opacity(0.05), radius: 4, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    ProjectsView()
}
