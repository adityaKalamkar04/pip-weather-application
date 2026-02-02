//
//  SnapshotHelper.swift
//  PIPWeatherApplicationTests
//
//  Created by Snapshot Tests on 01/02/26.
//

import SwiftUI
import XCTest

/// Snapshot testing helper for capturing and comparing UI screenshots
class SnapshotHelper {
    
    // MARK: - Configuration
    
    /// Flag to control snapshot recording mode
    /// Set to true to record new reference images
    /// Set to false to compare against existing reference images
    static var isRecording: Bool = false
    
    /// Directory name for storing reference images
    private static let referenceImageFolder = "referencesImage"
    
    // MARK: - Public Methods
    
    /// Captures a snapshot of a SwiftUI view
    /// - Parameters:
    ///   - view: The SwiftUI view to snapshot
    ///   - named: Name for the snapshot file
    ///   - testCase: The XCTestCase instance
    ///   - file: Source file (auto-filled)
    ///   - line: Source line (auto-filled)
    static func assertSnapshot<V: View>(
        of view: V,
        named name: String,
        in testCase: XCTestCase,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let hostingController = UIHostingController(rootView: view)
        hostingController.view.frame = UIScreen.main.bounds
        hostingController.view.layoutIfNeeded()
        
        assertSnapshot(
            of: hostingController,
            named: name,
            in: testCase,
            file: file,
            line: line
        )
    }
    
    /// Captures a snapshot of a UIViewController
    /// - Parameters:
    ///   - viewController: The UIViewController to snapshot
    ///   - named: Name for the snapshot file
    ///   - testCase: The XCTestCase instance
    ///   - file: Source file (auto-filled)
    ///   - line: Source line (auto-filled)
    static func assertSnapshot(
        of viewController: UIViewController,
        named name: String,
        in testCase: XCTestCase,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        guard let view = viewController.view else {
            XCTFail("ViewController has no view", file: file, line: line)
            return
        }
        
        view.layoutIfNeeded()
        
        let renderer = UIGraphicsImageRenderer(bounds: view.bounds)
        let screenshot = renderer.image { context in
            view.layer.render(in: context.cgContext)
        }
        
        if isRecording {
            // Recording mode: Save new reference image
            saveReferenceImage(screenshot, named: name, in: testCase, file: file, line: line)
        } else {
            // Comparison mode: Compare against reference image
            compareWithReferenceImage(screenshot, named: name, in: testCase, file: file, line: line)
        }
    }
    
    /// Captures a snapshot with custom size
    /// - Parameters:
    ///   - view: The SwiftUI view to snapshot
    ///   - size: Custom size for the snapshot
    ///   - named: Name for the snapshot file
    ///   - testCase: The XCTestCase instance
    ///   - file: Source file (auto-filled)
    ///   - line: Source line (auto-filled)
    static func assertSnapshot<V: View>(
        of view: V,
        size: CGSize,
        named name: String,
        in testCase: XCTestCase,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let hostingController = UIHostingController(rootView: view)
        hostingController.view.frame = CGRect(origin: .zero, size: size)
        hostingController.view.layoutIfNeeded()
        
        assertSnapshot(
            of: hostingController,
            named: name,
            in: testCase,
            file: file,
            line: line
        )
    }
    
    // MARK: - Private Methods
    
    private static func saveReferenceImage(
        _ image: UIImage,
        named name: String,
        in testCase: XCTestCase,
        file: StaticString,
        line: UInt
    ) {
        let referenceImageURL = getReferenceImageURL(for: name, in: testCase)
        
        // Create directory if it doesn't exist
        let directoryURL = referenceImageURL.deletingLastPathComponent()
        try? FileManager.default.createDirectory(
            at: directoryURL,
            withIntermediateDirectories: true,
            attributes: nil
        )
        
        // Save image
        guard let data = image.pngData() else {
            XCTFail("Failed to convert image to PNG data", file: file, line: line)
            return
        }
        
        do {
            try data.write(to: referenceImageURL)
            print("✅ Saved reference image: \(name)")
            print("   Location: \(referenceImageURL.path)")
        } catch {
            XCTFail("Failed to save reference image: \(error.localizedDescription)", file: file, line: line)
        }
    }
    
    private static func compareWithReferenceImage(
        _ image: UIImage,
        named name: String,
        in testCase: XCTestCase,
        file: StaticString,
        line: UInt
    ) {
        let referenceImageURL = getReferenceImageURL(for: name, in: testCase)
        
        // Check if reference image exists
        guard FileManager.default.fileExists(atPath: referenceImageURL.path) else {
            XCTFail(
                """
                Reference image not found: \(name)
                
                To record a reference image, set:
                    SnapshotHelper.isRecording = true
                
                And run the test again.
                """,
                file: file,
                line: line
            )
            return
        }
        
        // Load reference image
        guard let referenceData = try? Data(contentsOf: referenceImageURL),
              let referenceImage = UIImage(data: referenceData) else {
            XCTFail("Failed to load reference image: \(name)", file: file, line: line)
            return
        }
        
        // Compare images
        let imagesMatch = compareImages(image, referenceImage)
        
        if !imagesMatch {
            // Save failure images for debugging
            saveFailureImages(current: image, reference: referenceImage, named: name, in: testCase)
            
            XCTFail(
                """
                Snapshot comparison failed for: \(name)
                
                The current view does not match the reference image.
                Check the failure images in the test results for details.
                
                If the changes are intentional, set:
                    SnapshotHelper.isRecording = true
                
                And run the test again to update the reference image.
                """,
                file: file,
                line: line
            )
        } else {
            print("✅ Snapshot test passed: \(name)")
        }
    }
    
    private static func compareImages(_ image1: UIImage, _ image2: UIImage) -> Bool {
        guard let data1 = image1.pngData(),
              let data2 = image2.pngData() else {
            return false
        }
        
        return data1 == data2
    }
    
    private static func getReferenceImageURL(for name: String, in testCase: XCTestCase) -> URL {
        let testBundle = Bundle(for: type(of: testCase))
        guard let bundleURL = testBundle.resourceURL else {
            fatalError("Failed to get bundle URL")
        }
        
        let referenceImagesDirectory = bundleURL
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .appendingPathComponent(referenceImageFolder)
        
        return referenceImagesDirectory.appendingPathComponent("\(name).png")
    }
    
    private static func saveFailureImages(
        current: UIImage,
        reference: UIImage,
        named name: String,
        in testCase: XCTestCase
    ) {
        let testBundle = Bundle(for: type(of: testCase))
        guard let bundleURL = testBundle.resourceURL else { return }
        
        let failureDirectory = bundleURL
            .deletingLastPathComponent()
            .deletingLastPathComponent()
            .appendingPathComponent("SnapshotFailures")
        
        // Create failure directory
        try? FileManager.default.createDirectory(
            at: failureDirectory,
            withIntermediateDirectories: true,
            attributes: nil
        )
        
        // Save current image
        if let currentData = current.pngData() {
            let currentURL = failureDirectory.appendingPathComponent("\(name)_current.png")
            try? currentData.write(to: currentURL)
            print("📸 Saved current image: \(currentURL.path)")
        }
        
        // Save reference image
        if let referenceData = reference.pngData() {
            let referenceURL = failureDirectory.appendingPathComponent("\(name)_reference.png")
            try? referenceData.write(to: referenceURL)
            print("📸 Saved reference image: \(referenceURL.path)")
        }
        
        // Generate diff image
        if let diffImage = generateDiffImage(current: current, reference: reference),
           let diffData = diffImage.pngData() {
            let diffURL = failureDirectory.appendingPathComponent("\(name)_diff.png")
            try? diffData.write(to: diffURL)
            print("📸 Saved diff image: \(diffURL.path)")
        }
    }
    
    private static func generateDiffImage(current: UIImage, reference: UIImage) -> UIImage? {
        guard let currentCGImage = current.cgImage,
              let referenceCGImage = reference.cgImage,
              currentCGImage.width == referenceCGImage.width,
              currentCGImage.height == referenceCGImage.height else {
            return nil
        }
        
        let size = CGSize(width: currentCGImage.width, height: currentCGImage.height)
        let renderer = UIGraphicsImageRenderer(size: size)
        
        return renderer.image { context in
            // Draw reference in grayscale
            context.cgContext.setAlpha(0.5)
            reference.draw(at: .zero)
            
            // Draw differences in red
            context.cgContext.setBlendMode(.difference)
            context.cgContext.setFillColor(UIColor.red.cgColor)
            current.draw(at: .zero)
        }
    }
}

// MARK: - Device Configurations

extension SnapshotHelper {
    
    /// Common device sizes for snapshot testing
    enum DeviceSize {
        case iPhoneSE       // 375 x 667
        case iPhone8        // 375 x 667
        case iPhone14       // 390 x 844
        case iPhone14Pro    // 393 x 852
        case iPhone14ProMax // 430 x 932
        case iPadPro11      // 834 x 1194
        case iPadPro129     // 1024 x 1366
        
        var size: CGSize {
            switch self {
            case .iPhoneSE, .iPhone8:
                return CGSize(width: 375, height: 667)
            case .iPhone14:
                return CGSize(width: 390, height: 844)
            case .iPhone14Pro:
                return CGSize(width: 393, height: 852)
            case .iPhone14ProMax:
                return CGSize(width: 430, height: 932)
            case .iPadPro11:
                return CGSize(width: 834, height: 1194)
            case .iPadPro129:
                return CGSize(width: 1024, height: 1366)
            }
        }
        
        var name: String {
            switch self {
            case .iPhoneSE: return "iPhone-SE"
            case .iPhone8: return "iPhone-8"
            case .iPhone14: return "iPhone-14"
            case .iPhone14Pro: return "iPhone-14-Pro"
            case .iPhone14ProMax: return "iPhone-14-Pro-Max"
            case .iPadPro11: return "iPad-Pro-11"
            case .iPadPro129: return "iPad-Pro-12.9"
            }
        }
    }
}
