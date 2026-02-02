//
//  TakeAPhotoView.swift
//  PIPWeatherApplication
//
//  Created by a.unmesh.kalamkar on 27/01/26.
//

import SwiftUI
import AVFoundation

struct TakeAPhotoView: View {
    @EnvironmentObject var appEnvironment: AppEnvironment
    @State private var showCamera = false
    @State private var capturedImage: UIImage?
    @State private var showSimulatorAlert = false
    @State private var cameraPermissionDenied = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                // Background
                if let image = capturedImage {
                // Show captured image
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            } else {
                // Camera preview background
                Color.black
                    .ignoresSafeArea()
            }
            
            // Camera overlay
            VStack {
                // Top bar
                topBar
                
                Spacer()
                
                // Camera controls
                cameraControls
            }
            
            // Simulator alert overlay
            if showSimulatorAlert {
                simulatorAlertOverlay
            }
            
            // Permission denied alert
            if cameraPermissionDenied {
                permissionDeniedOverlay
            }
        }
        .sheet(isPresented: $showCamera) {
            if DeviceDetector.isRealDevice {
                CameraView(image: $capturedImage)
                    .ignoresSafeArea()
            }
        }
        .onAppear {
            DeviceDetector.log("TakeAPhotoView appeared on \(DeviceDetector.isSimulator ? "Simulator" : "Real Device")", type: .info)
            
            // Show simulator alert immediately when tab appears
            if DeviceDetector.isSimulator {
                showSimulatorAlert = true
            }
        }
        .navigationBarHidden(true)
        }
    }
    
    // MARK: - Subviews
    
    private var topBar: some View {
        HStack {
            // Search button
            Button(action: {
                // Search action
            }) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 22))
                    .foregroundColor(.white)
                    .frame(width: 44, height: 44)
            }
            
            Spacer()
            
            // Notification bell
            NavigationLink(destination: NotificationDetailView(notification: getDefaultNotification())) {
                ZStack(alignment: .topTrailing) {
                    Image(systemName: "bell")
                        .font(.system(size: 22))
                        .foregroundColor(.white)
                    
                    // Notification badge
                    Circle()
                        .fill(Color.greenTagNotification)
                        .frame(width: 8, height: 8)
                        .offset(x: 4, y: -4)
                }
                .frame(width: 44, height: 44)
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
    
    private func getDefaultNotification() -> AppNotification {
        return AppNotification(
            id: "default",
            title: "Camera Notification",
            message: "Your photos and project updates will appear here.",
            time: "Now",
            isUrgent: false,
            icon: "bell.fill"
        )
    }
    
    private var cameraControls: some View {
        VStack(spacing: 20) {
            // Mode switcher (Pano / Photo)
            HStack(spacing: 40) {
                Text("Pano")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(.white.opacity(0.6))
                
                Text("Photo")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.white)
            }
            .padding(.bottom, 30)
            
            // Capture button
            Button(action: {
                capturePhoto()
            }) {
                ZStack {
                    Circle()
                        .stroke(Color.white, lineWidth: 4)
                        .frame(width: 80, height: 80)
                    
                    Circle()
                        .fill(Color.white)
                        .frame(width: 68, height: 68)
                }
            }
            
            // Clear image button (if image captured)
            if capturedImage != nil {
                Button(action: {
                    capturedImage = nil
                }) {
                    Text("Retake Photo")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 12)
                        .background(Color.greenTagPrimary)
                        .cornerRadius(12)
                }
                .padding(.top, 8)
            }
        }
        .padding(.bottom, 40)
    }
    
    private var simulatorAlertOverlay: some View {
        ZStack {
            // Blurred black background
            Color.black.opacity(0.8)
                .ignoresSafeArea()
                .blur(radius: 20)
            
            // Alert card
            VStack(spacing: 24) {
                // Icon
                Image(systemName: "camera.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.white)
                
                // Title
                Text("Camera Not Available")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                
                // Message
                Text("Camera is not supported on the simulator.\nPlease run this app on a real device to use the camera.")
                    .font(.system(size: 16))
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                
                // OK Button
                Button(action: {
                    showSimulatorAlert = false
                    // Navigate back to Today tab
                    appEnvironment.selectedTab = .today
                }) {
                    Text("OK")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.greenTagPrimary)
                        .cornerRadius(12)
                }
                .padding(.horizontal, 40)
                .padding(.top, 8)
            }
            .padding(32)
            .background(Color.black.opacity(0.9))
            .cornerRadius(20)
            .padding(.horizontal, 40)
        }
    }
    
    private var permissionDeniedOverlay: some View {
        ZStack {
            // Blurred black background
            Color.black.opacity(0.8)
                .ignoresSafeArea()
                .blur(radius: 20)
            
            // Alert card
            VStack(spacing: 24) {
                // Icon
                Image(systemName: "exclamationmark.triangle.fill")
                    .font(.system(size: 60))
                    .foregroundColor(.orange)
                
                // Title
                Text("Camera Access Denied")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                
                // Message
                Text("Please enable camera access in Settings to take photos.")
                    .font(.system(size: 16))
                    .foregroundColor(.white.opacity(0.9))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                
                // Buttons
                VStack(spacing: 12) {
                    Button(action: {
                        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                            UIApplication.shared.open(settingsURL)
                        }
                    }) {
                        Text("Open Settings")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.greenTagPrimary)
                            .cornerRadius(12)
                    }
                    
                    Button(action: {
                        cameraPermissionDenied = false
                    }) {
                        Text("Cancel")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                    }
                }
                .padding(.horizontal, 40)
                .padding(.top, 8)
            }
            .padding(32)
            .background(Color.black.opacity(0.9))
            .cornerRadius(20)
            .padding(.horizontal, 40)
        }
    }
    
    // MARK: - Actions
    
    private func capturePhoto() {
        // Check if running on simulator (shouldn't happen as alert shows on appear)
        if DeviceDetector.isSimulator {
            DeviceDetector.log("Camera not available on simulator", type: .warning)
            showSimulatorAlert = true
            return
        }
        
        // Check camera permission
        checkCameraPermission()
    }
    
    private func checkCameraPermission() {
        let status = AVCaptureDevice.authorizationStatus(for: .video)
        
        switch status {
        case .authorized:
            // Permission already granted
            showCamera = true
            
        case .notDetermined:
            // Request permission
            AVCaptureDevice.requestAccess(for: .video) { granted in
                DispatchQueue.main.async {
                    if granted {
                        showCamera = true
                    } else {
                        cameraPermissionDenied = true
                    }
                }
            }
            
        case .denied, .restricted:
            // Permission denied
            cameraPermissionDenied = true
            
        @unknown default:
            cameraPermissionDenied = true
        }
    }
}

// MARK: - Camera View Wrapper
struct CameraView: UIViewControllerRepresentable {
    @Environment(\.dismiss) var dismiss
    @Binding var image: UIImage?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.delegate = context.coordinator
        picker.allowsEditing = true
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: CameraView
        
        init(_ parent: CameraView) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let editedImage = info[.editedImage] as? UIImage {
                parent.image = editedImage
            } else if let originalImage = info[.originalImage] as? UIImage {
                parent.image = originalImage
            }
            
            DeviceDetector.log("Photo captured successfully", type: .success)
            parent.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            DeviceDetector.log("Camera cancelled", type: .info)
            parent.dismiss()
        }
    }
}

#Preview {
    TakeAPhotoView()
        .environmentObject(AppEnvironment.shared)
}
