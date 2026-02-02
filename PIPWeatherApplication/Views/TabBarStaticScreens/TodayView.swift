//
//  TodayView.swift
//  PIPWeatherApplication
//
//  Created by a.unmesh.kalamkar on 27/01/26.
//

import SwiftUI

struct TodayView: View {
    @StateObject private var viewModel = TodayViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                    // Header
                    headerView
                    
                    // Content
                    ScrollView {
                        VStack(alignment: .leading, spacing: 20) {
                            // Today title with date
                            HStack(alignment: .firstTextBaseline, spacing: 6) {
                                Text("Today")
                                    .font(.system(size: 34, weight: .bold))
                                    .foregroundColor(.textPrimary)
                                
                                Text(viewModel.dateDisplay)
                                    .font(.system(size: 34, weight: .regular))
                                    .foregroundColor(.textTertiary)
                            }
                            .padding(.horizontal)
                            .padding(.top, 16)
                            
                            // Today items
                            ForEach(viewModel.todayItems) { item in
                                if item.isProject {
                                    ProjectTodayCard(item: item)
                                        .padding(.horizontal)
                                } else if item.isNotification {
                                    NotificationCard(item: item)
                                        .padding(.horizontal)
                                }
                            }
                        
                        // Weather forecast
                        WeatherForecastView(forecast: viewModel.weatherForecast)
                            .padding(.horizontal)
                            .padding(.bottom, 20)
                    }
                }
            }
            .navigationBarHidden(true)
        }
        }
        .onAppear {
            viewModel.loadToday()
        }
    }
    
    // MARK: - Helper Methods
    
    private func getLatestNotification() -> AppNotification {
        // Get the first notification item from today items
        let notificationItem = viewModel.todayItems.first { $0.isNotification }
        
        if let item = notificationItem {
            return AppNotification(
                id: item.id,
                title: item.title,
                message: item.message ?? "No details available",
                time: item.time ?? "Just now",
                isUrgent: item.isUrgent,
                icon: "bell.fill"
            )
        }
        
        // Default notification if none found
        return AppNotification(
            id: "default",
            title: "No New Notifications",
            message: "You're all caught up! Check back later for updates.",
            time: "Now",
            isUrgent: false,
            icon: "bell.fill"
        )
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
            NavigationLink(destination: NotificationDetailView(notification: getLatestNotification())) {
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
}

// MARK: - Project Today Card
struct ProjectTodayCard: View {
    let item: TodayItem
    
    var body: some View {
        NavigationLink(destination: ProjectDetailView(project: Project(
            id: item.id,
            title: item.title,
            status: item.status ?? "Active",
            tags: item.tags ?? [],
            description: item.message,
            imageUrl: item.imageUrl,
            location: nil
        ))) {
            ZStack(alignment: .bottomLeading) {
                // Background image
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .frame(height: 260)
                    .cornerRadius(16)
                
                VStack(alignment: .leading) {
                    Spacer()
                    
                    Text(item.title)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.white)
                        .shadow(color: .black.opacity(0.3), radius: 2, x: 0, y: 1)
                    
                    HStack {
                        Text(item.status ?? "Open")
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

// MARK: - Notification Card
struct NotificationCard: View {
    let item: TodayItem
    
    var body: some View {
        NavigationLink(destination: NotificationDetailView(notification: AppNotification(
            id: item.id,
            title: item.title,
            message: item.message ?? "",
            time: item.time ?? "",
            isUrgent: item.isUrgent,
            icon: "bell.fill"
        ))) {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 8) {
                    Image(systemName: "bell.fill")
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                    
                    Text(item.title)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Spacer()
                    
                    Image(systemName: "arrow.right")
                        .font(.system(size: 14))
                        .foregroundColor(.white.opacity(0.8))
                }
                
                Text(item.message ?? "")
                    .font(.system(size: 15))
                    .foregroundColor(.white.opacity(0.95))
                    .lineSpacing(4)
                
                HStack {
                    Text(item.action ?? "View Details")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
                .frame(height: 48)
                .padding(.horizontal, 16)
                .background(Color.greenTagDark)
                .cornerRadius(12)
            }
            .padding(20)
            .background(Color.notificationGreen)
            .cornerRadius(16)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

// MARK: - Weather Forecast View
struct WeatherForecastView: View {
    let forecast: WeatherForecast?
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(forecast?.days ?? []) { day in
                VStack(spacing: 12) {
                    Text(day.day)
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(.textSecondary)
                    
                    // Weather icon
                    Image(systemName: weatherIcon(for: day))
                        .font(.system(size: 32))
                        .foregroundColor(iconColor(for: day))
                    
                    Text(day.displayTemp)
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(.textPrimary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(day.day == "TUE" ? Color.white : Color.clear)
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(day.day == "TUE" ? Color.borderLight : Color.clear, lineWidth: 1)
                )
            }
        }
        .padding(.vertical, 8)
    }
    
    private func weatherIcon(for day: WeatherDay) -> String {
        day.icon ?? "sun.max.fill"
    }
    
    private func iconColor(for day: WeatherDay) -> Color {
        if let icon = day.icon, icon.contains("cloud") {
            return .weatherCloud
        }
        return .weatherSun
    }
}

#Preview {
    TodayView()
}
