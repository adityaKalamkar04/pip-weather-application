//
//  JSONLoader.swift
//  PIPWeatherApplication
//
//  Created by a.unmesh.kalamkar on 29/01/26.
//

import Foundation

struct JSONLoader {
    // MARK: - Load and Decode JSON
    static func load<T: Decodable>(
        _ type: T.Type,
        from filename: String,
        withExtension ext: String = "json"
    ) -> Result<T, JSONError> {
        // Attempt to locate the file in the bundle
        guard let fileURL = Bundle.main.url(forResource: filename, withExtension: ext) else {
            DeviceDetector.log("File '\(filename).\(ext)' not found in bundle", type: .error)
            return .failure(.fileNotFound(filename: "\(filename).\(ext)"))
        }
        
        // Attempt to read data from file
        guard let data = try? Data(contentsOf: fileURL) else {
            DeviceDetector.log("Failed to load data from '\(filename).\(ext)'", type: .error)
            return .failure(.dataLoadFailed)
        }
        
        // Attempt to decode the data
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let decoded = try decoder.decode(T.self, from: data)
            DeviceDetector.log("Successfully loaded '\(filename).\(ext)'", type: .success)
            return .success(decoded)
        } catch {
            DeviceDetector.log("Failed to decode '\(filename).\(ext)': \(error.localizedDescription)", type: .error)
            return .failure(.decodingFailed(error: error))
        }
    }
    
    // MARK: - Synchronous Load (throws)
    static func loadSync<T: Decodable>(
        _ type: T.Type,
        from filename: String,
        withExtension ext: String = "json"
    ) throws -> T {
        let result = load(type, from: filename, withExtension: ext)
        switch result {
        case .success(let data):
            return data
        case .failure(let error):
            throw error
        }
    }
}

// MARK: - JSON Error Types
enum JSONError: LocalizedError {
    case fileNotFound(filename: String)
    case dataLoadFailed
    case decodingFailed(error: Error)
    
    var errorDescription: String? {
        switch self {
        case .fileNotFound(let filename):
            return "File '\(filename)' not found in bundle"
        case .dataLoadFailed:
            return "Failed to load data from file"
        case .decodingFailed(let error):
            return "Failed to decode JSON: \(error.localizedDescription)"
        }
    }
}
