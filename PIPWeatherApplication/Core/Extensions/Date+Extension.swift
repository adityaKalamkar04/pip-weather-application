//
//  Date+Extension.swift
//  PIPWeatherApplication
//
//  Created by a.unmesh.kalamkar on 30/01/26.
//

import Foundation

extension Date {
    /// Format date to hour string (e.g., "3PM")
    func toHourString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = AppConstants.DateFormat.hourly
        return formatter.string(from: self)
    }
    
    /// Format date to day string (e.g., "Monday")
    func toDayString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = AppConstants.DateFormat.daily
        return formatter.string(from: self)
    }
    
    /// Format date to full date string (e.g., "January 26, 2026")
    func toFullDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = AppConstants.DateFormat.fullDate
        return formatter.string(from: self)
    }
    
    /// Format date to short date string (e.g., "Jan 26")
    func toShortDateString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = AppConstants.DateFormat.dayMonth
        return formatter.string(from: self)
    }
    
    /// Check if date is today
    var isToday: Bool {
        Calendar.current.isDateInToday(self)
    }
    
    /// Check if date is in the future
    var isFuture: Bool {
        self > Date()
    }
    
    /// Get hour component (0-23)
    var hour: Int {
        Calendar.current.component(.hour, from: self)
    }
    
    /// Check if it's daytime (6 AM - 6 PM)
    var isDaytime: Bool {
        let hour = self.hour
        return hour >= 6 && hour < 18
    }
}
