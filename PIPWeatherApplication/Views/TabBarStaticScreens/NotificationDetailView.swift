//
//  NotificationDetailView.swift
//  PIPWeatherApplication
//
//  Created by a.unmesh.kalamkar on 28/01/26.
//

import SwiftUI

struct NotificationDetailView: View {
    let notification: AppNotification
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Icon and title
                HStack(alignment: .top, spacing: 16) {
                    Image(systemName: notification.icon)
                        .font(.system(size: 40))
                        .foregroundColor(.greenTagPrimary)
                        .frame(width: 60, height: 60)
                        .background(Color.greenTagLight.opacity(0.2))
                        .cornerRadius(30)
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(notification.title)
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.textPrimary)
                        
                        Text(notification.time)
                            .font(.system(size: 14))
                            .foregroundColor(.textSecondary)
                    }
                }
                
                Divider()
                
                // Notification content
                VStack(alignment: .leading, spacing: 16) {
                    Text("Details")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.textPrimary)
                    
                    Text(notification.message)
                        .font(.system(size: 16))
                        .foregroundColor(.textSecondary)
                        .lineSpacing(4)
                    
                    if notification.isUrgent {
                        HStack {
                            Image(systemName: "exclamationmark.triangle.fill")
                                .foregroundColor(.red)
                            Text("Urgent")
                                .font(.system(size: 14, weight: .semibold))
                                .foregroundColor(.red)
                        }
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(8)
                    }
                }
                
                // Action buttons
                VStack(spacing: 12) {
                    Button(action: {
                        // Mark as read
                        dismiss()
                    }) {
                        Text("Mark as Read")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.greenTagPrimary)
                            .cornerRadius(12)
                    }
                    
                    Button(action: {
                        // View related project
                    }) {
                        Text("View Project")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.greenTagPrimary)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.greenTagLight.opacity(0.2))
                            .cornerRadius(12)
                    }
                }
                .padding(.top, 16)
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    NavigationStack {
        NotificationDetailView(notification: AppNotification(
            id: "1",
            title: "New Update",
            message: "Your project has been updated with new information. Please review the changes.",
            time: "10:30 AM",
            isUrgent: true,
            icon: "bell.fill"
        ))
    }
}
