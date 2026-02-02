//
//  TemperatureConverter.swift
//  PIPWeatherApplication
//
//  Created by a.unmesh.kalamkar on 30/01/26.
//

import Foundation

struct TemperatureConverter {
    // MARK: - Conversion Methods
    
    /// Convert Celsius to Fahrenheit
    static func celsiusToFahrenheit(_ celsius: Double) -> Double {
        return (celsius * 9/5) + 32
    }
    
    /// Convert Fahrenheit to Celsius
    static func fahrenheitToCelsius(_ fahrenheit: Double) -> Double {
        return (fahrenheit - 32) * 5/9
    }
    
    /// Format temperature with unit
    static func formatted(
        _ temperature: Double,
        unit: AppConstants.TemperatureUnit,
        decimals: Int = 0
    ) -> String {
        let formatted = String(format: "%.\(decimals)f", temperature)
        return "\(formatted)\(unit.rawValue)"
    }
    
    /// Convert and format temperature
    static func convert(
        _ temperature: Double,
        from: AppConstants.TemperatureUnit,
        to: AppConstants.TemperatureUnit,
        decimals: Int = 0
    ) -> String {
        var convertedTemp = temperature
        
        if from == .celsius && to == .fahrenheit {
            convertedTemp = celsiusToFahrenheit(temperature)
        } else if from == .fahrenheit && to == .celsius {
            convertedTemp = fahrenheitToCelsius(temperature)
        }
        
        return formatted(convertedTemp, unit: to, decimals: decimals)
    }
    
    /// Get temperature with proper formatting
    static func display(
        _ temperature: Double,
        unit: AppConstants.TemperatureUnit = .celsius
    ) -> String {
        return formatted(temperature, unit: unit)
    }
    
    /// Round to nearest integer
    static func rounded(_ temperature: Double) -> Int {
        return Int(temperature.rounded())
    }
}
