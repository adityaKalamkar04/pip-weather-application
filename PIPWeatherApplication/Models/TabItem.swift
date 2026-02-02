//
//  TabItem.swift
//  PIPWeatherApplication
//
//  Created by a.unmesh.kalamkar on 27/01/26.
//

import SwiftUI

enum TabItem: Int, CaseIterable {
    case today
    case projects
    case takePhoto
    case ask
    
    var title: String {
        switch self {
        case .today: return "Today"
        case .projects: return "Projects"
        case .takePhoto: return "Take Photo"
        case .ask: return "Ask"
        }
    }
    
    var icon: String {
        switch self {
        case .today: return "calendar"
        case .projects: return "hammer.circle.fill"
        case .takePhoto: return "camera.fill"
        case .ask: return "message.fill"
        }
    }
    
    var inactiveIcon: String {
        switch self {
        case .today: return "calendar"
        case .projects: return "hammer.circle"
        case .takePhoto: return "camera"
        case .ask: return "message"
        }
    }
}
