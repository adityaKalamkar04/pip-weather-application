//
//  DeviceDetector.swift
//  PIPWeatherApplication
//
//  Created by a.unmesh.kalamkar on 28/01/26.
//

import Foundation

struct DeviceDetector {
    // MARK: - Device Type Detection
    static var isSimulator: Bool {
        #if targetEnvironment(simulator)
        return true
        #else
        return false
        #endif
    }
    
    static var isRealDevice: Bool {
        !isSimulator
    }
    
    // MARK: - Environment Info
    static var deviceInfo: String {
        let deviceType = isSimulator ? "Simulator" : "Real Device"
        let modelName = deviceModelName
        return "\(deviceType) - \(modelName)"
    }
    
    static var deviceModelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }
    
    // MARK: - Debug Logger
    static func log(_ message: String, type: LogType = .info) {
        #if DEBUG
        let prefix = isSimulator ? "[SIMULATOR]" : "[DEVICE]"
        let typeEmoji = type.emoji
        print("\(prefix) \(typeEmoji) \(message)")
        #endif
    }
    
    enum LogType {
        case info
        case warning
        case error
        case success
        
        var emoji: String {
            switch self {
            case .info: return "ℹ️"
            case .warning: return "⚠️"
            case .error: return "❌"
            case .success: return "✅"
            }
        }
    }
}
