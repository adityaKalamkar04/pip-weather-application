//
//  AppConstants.swift
//  PIPWeatherApplication
//
//  Created by a.unmesh.kalamkar on 23/01/26.
//

import Foundation

enum AppConstants {
    // MARK: - App Info
    static let appName = "Weather"
    static let appVersion = "1.0.0"
    
    // MARK: - JSON Data
    static let weatherDataFileName = "weather_data"
    static let weatherDataFileExtension = "json"
    
    // MARK: - Temperature Units
    enum TemperatureUnit: String {
        case celsius = "°C"
        case fahrenheit = "°F"
    }
    
    // MARK: - Date Formats
    enum DateFormat {
        static let hourly = "ha"
        static let daily = "EEEE"
        static let fullDate = "MMMM d, yyyy"
        static let dayMonth = "MMM d"
    }
    
    // MARK: - Weather Icons
    enum WeatherIcon: String {
        case clear = "sun.max.fill"
        case cloudy = "cloud.fill"
        case rainy = "cloud.rain.fill"
        case stormy = "cloud.bolt.fill"
        case snowy = "cloud.snow.fill"
        case windy = "wind"
        case partlyCloudy = "cloud.sun.fill"
        case foggy = "cloud.fog.fill"
        
        static func icon(for condition: String) -> String {
            switch condition.lowercased() {
            case "clear", "sunny":
                return WeatherIcon.clear.rawValue
            case "cloudy":
                return WeatherIcon.cloudy.rawValue
            case "rain", "rainy":
                return WeatherIcon.rainy.rawValue
            case "storm", "thunderstorm":
                return WeatherIcon.stormy.rawValue
            case "snow", "snowy":
                return WeatherIcon.snowy.rawValue
            case "wind", "windy":
                return WeatherIcon.windy.rawValue
            case "partly cloudy":
                return WeatherIcon.partlyCloudy.rawValue
            case "fog", "foggy":
                return WeatherIcon.foggy.rawValue
            default:
                return WeatherIcon.clear.rawValue
            }
        }
    }
    
    // MARK: - Animation Durations
    enum Animation {
        static let fast = 0.2
        static let normal = 0.3
        static let slow = 0.5
    }
    
    // MARK: - Layout
    enum Layout {
        static let cornerRadius: CGFloat = 16
        static let smallCornerRadius: CGFloat = 8
        static let padding: CGFloat = 16
        static let smallPadding: CGFloat = 8
        static let iconSize: CGFloat = 24
        static let largeIconSize: CGFloat = 64
    }
}
