//
//  WeatherApp.swift
//  PIPWeatherApplication
//
//  Created by a.unmesh.kalamkar on 27/01/26.
//

import SwiftUI

@main
struct WeatherApp: App {
    @StateObject private var appEnvironment = AppEnvironment.shared
    @State private var isLoggedIn: Bool = false // Shows login screen first
    
    var body: some Scene {
        WindowGroup {
            if isLoggedIn {
                MainTabView()
                    .environmentObject(appEnvironment)
            } else {
                LoginView(isLoggedIn: $isLoggedIn)
            }
        }
    }
}

struct MainTabView: View {
    @EnvironmentObject var appEnvironment: AppEnvironment
    
    var body: some View {
        ZStack {
            // Main content
            VStack(spacing: 0) {
                // Content view based on selected tab
                contentView
                
                // Custom tab bar
                CustomTabBar(selectedTab: $appEnvironment.selectedTab)
            }
        }
        .ignoresSafeArea(.keyboard)
    }
    
    @ViewBuilder
    private var contentView: some View {
        switch appEnvironment.selectedTab {
        case .today:
            TodayView()
                .transition(.opacity)
        case .projects:
            ProjectsView()
                .transition(.opacity)
        case .takePhoto:
            TakeAPhotoView()
                .transition(.opacity)
        case .ask:
            AskView()
                .transition(.opacity)
        }
    }
}

#Preview {
    MainTabView()
        .environmentObject(AppEnvironment.shared)
}
