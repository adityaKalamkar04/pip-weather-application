//
//  String+Extension.swift
//  PIPWeatherApplication
//
//  Created by a.unmesh.kalamkar on 30/01/26.
//

import Foundation

extension String {
    /// Capitalize first letter of string
    var capitalizedFirst: String {
        guard !isEmpty else { return self }
        return prefix(1).uppercased() + dropFirst()
    }
    
    /// Check if string is empty or contains only whitespace
    var isBlankOrEmpty: Bool {
        trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
    /// Convert string to Date
    func toDate(format: String = "yyyy-MM-dd'T'HH:mm:ss") -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        formatter.timeZone = TimeZone.current
        return formatter.date(from: self)
    }
    
    /// Truncate string to specified length
    func truncated(to length: Int, trailing: String = "...") -> String {
        guard self.count > length else { return self }
        return self.prefix(length) + trailing
    }
}
