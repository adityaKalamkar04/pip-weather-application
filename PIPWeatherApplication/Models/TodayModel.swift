//
//  TodayModel.swift
//  PIPWeatherApplication
//
//  Created by a.unmesh.kalamkar on 23/01/26.
//

import Foundation

// MARK: - User
struct User: Codable {
    let name: String
    let greeting: String
    let email: String?
    
    var welcomeMessage: String {
        "\(greeting), \(name)"
    }
}

// MARK: - Project
struct Project: Codable, Identifiable {
    let id: String
    let name: String
    let status: String
    let tags: [String]
    let description: String
    let imageName: String?
    let imageUrl: String?
    let location: String?
    let createdAt: String?
    let updatedAt: String?
    
    var isOpen: Bool {
        status.lowercased() == "open"
    }
    
    var title: String {
        name
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, status, tags, description, imageName, location, createdAt, updatedAt
        case imageUrl = "image_url"
    }
    
    init(id: String = UUID().uuidString, name: String = "", title: String = "", status: String = "Active", tags: [String] = [], description: String? = nil, imageName: String? = nil, imageUrl: String? = nil, location: String? = nil, createdAt: String? = nil, updatedAt: String? = nil) {
        self.id = id
        self.name = title.isEmpty ? name : title
        self.status = status
        self.tags = tags
        self.description = description ?? ""
        self.imageName = imageName
        self.imageUrl = imageUrl
        self.location = location
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

// MARK: - Today Item
struct TodayItem: Codable, Identifiable {
    let id: String
    let type: String
    let title: String
    let status: String?
    let description: String?
    let message: String?
    let action: String?
    let urgencyHint: String?
    let time: String?
    let imageUrl: String?
    let tags: [String]?
    
    enum CodingKeys: String, CodingKey {
        case id, type, title, status, description, message, action, time, tags
        case urgencyHint = "urgency_hint"
        case imageUrl = "image_url"
    }
    
    var isProject: Bool {
        type.lowercased() == "project"
    }
    
    var isNotification: Bool {
        type.lowercased() == "notification"
    }
    
    var isUrgent: Bool {
        urgencyHint?.lowercased() == "high" || urgencyHint?.lowercased() == "urgent"
    }
}

// MARK: - Notification
struct AppNotification: Codable, Identifiable {
    let id: String
    let title: String
    let message: String
    let time: String
    let isUrgent: Bool
    let icon: String
    let action: String?
    let urgencyHint: String?
    let timestamp: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, message, time, isUrgent, icon, action
        case urgencyHint = "urgency_hint"
        case timestamp
    }
    
    init(id: String, title: String, message: String, time: String, isUrgent: Bool, icon: String, action: String? = nil, urgencyHint: String? = nil, timestamp: String? = nil) {
        self.id = id
        self.title = title
        self.message = message
        self.time = time
        self.isUrgent = isUrgent
        self.icon = icon
        self.action = action
        self.urgencyHint = urgencyHint
        self.timestamp = timestamp
    }
}

// MARK: - Weather Day
struct WeatherDay: Codable, Identifiable {
    let id: String
    let day: String
    let temperature: String
    let unit: String
    let icon: String?
    
    var displayTemp: String {
        temperature
    }
    
    init(id: String = UUID().uuidString, day: String, temperature: String, unit: String = "celsius", icon: String? = nil) {
        self.id = id
        self.day = day
        self.temperature = temperature
        self.unit = unit
        self.icon = icon
    }
}

// MARK: - Weather Forecast
struct WeatherForecast: Codable {
    let days: [WeatherDay]
    let note: String?
}

// MARK: - Today Response
struct TodayResponse: Codable {
    let status: String
    let data: TodayData
}

struct TodayData: Codable {
    let timestamp: String
    let user: User
    let date: DateInfo
    let todayItems: [TodayItem]
    let weatherForecast: WeatherForecast
    let navigation: Navigation
    let metadata: Metadata?
    
    enum CodingKeys: String, CodingKey {
        case timestamp, user, date
        case todayItems = "today_items"
        case weatherForecast = "weather_forecast"
        case navigation, metadata
    }
}

struct DateInfo: Codable {
    let display: String
    let fullDate: String
    
    enum CodingKeys: String, CodingKey {
        case display
        case fullDate = "full_date"
    }
}

// MARK: - Projects Response
struct ProjectsResponse: Codable {
    let status: String
    let data: ProjectsData
}

struct ProjectsData: Codable {
    let timestamp: String
    let user: User
    let projects: [Project]
    let navigation: Navigation
    let metadata: Metadata?
}

// MARK: - Navigation
struct Navigation: Codable {
    let tabs: [String]
    let activeTab: String
    
    enum CodingKeys: String, CodingKey {
        case tabs
        case activeTab = "active_tab"
    }
}

// MARK: - Metadata
struct Metadata: Codable {
    let source: String
    let interpretedLayout: String?
    let screenTitle: String?
    let context: String?
    
    enum CodingKeys: String, CodingKey {
        case source
        case interpretedLayout = "interpreted_layout"
        case screenTitle = "screen_title"
        case context
    }
}
