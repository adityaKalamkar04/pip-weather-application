//
//  ProjectDetailView.swift
//  PIPWeatherApplication
//
//  Created by a.unmesh.kalamkar on 28/01/26.
//

import SwiftUI

struct ProjectDetailView: View {
    let project: Project
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Project image
                if let imageUrl = project.imageUrl {
                    AsyncImage(url: URL(string: imageUrl)) { phase in
                        switch phase {
                        case .empty:
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 300)
                                .overlay(ProgressView())
                        case .success(let image):
                            image
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(height: 300)
                                .clipped()
                        case .failure:
                            Rectangle()
                                .fill(Color.gray.opacity(0.2))
                                .frame(height: 300)
                                .overlay(
                                    Image(systemName: "photo")
                                        .font(.system(size: 50))
                                        .foregroundColor(.gray)
                                )
                        @unknown default:
                            EmptyView()
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 16) {
                    // Project title
                    Text(project.title)
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.textPrimary)
                    
                    // Tags
                    HStack(spacing: 8) {
                        ForEach(project.tags, id: \.self) { tag in
                            Text(tag)
                                .font(.system(size: 12, weight: .medium))
                                .foregroundColor(.greenTagPrimary)
                                .padding(.horizontal, 12)
                                .padding(.vertical, 6)
                                .background(Color.greenTagLight.opacity(0.2))
                                .cornerRadius(12)
                        }
                    }
                    
                    // Description
                    if !project.description.isEmpty {
                        Text(project.description)
                            .font(.system(size: 16))
                            .foregroundColor(.textSecondary)
                            .padding(.top, 8)
                    }
                    
                    // Location
                    if let location = project.location {
                        HStack(spacing: 8) {
                            Image(systemName: "location.fill")
                                .foregroundColor(.greenTagPrimary)
                            Text(location)
                                .font(.system(size: 14))
                                .foregroundColor(.textSecondary)
                        }
                        .padding(.top, 8)
                    }
                    
                    // Status
                    HStack(spacing: 8) {
                        Image(systemName: "clock.fill")
                            .foregroundColor(.greenTagPrimary)
                        Text("Status: \(project.status)")
                            .font(.system(size: 14))
                            .foregroundColor(.textSecondary)
                    }
                    
                    // Action buttons
                    HStack(spacing: 12) {
                        Button(action: {
                            // Take photo action
                        }) {
                            HStack {
                                Image(systemName: "camera.fill")
                                Text("Take Photo")
                            }
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.greenTagPrimary)
                            .cornerRadius(12)
                        }
                        
                        Button(action: {
                            // Share action
                        }) {
                            Image(systemName: "square.and.arrow.up")
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.greenTagPrimary)
                                .frame(width: 50, height: 50)
                                .background(Color.greenTagLight.opacity(0.2))
                                .cornerRadius(12)
                        }
                    }
                    .padding(.top, 16)
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    // More options
                }) {
                    Image(systemName: "ellipsis.circle")
                        .foregroundColor(.textPrimary)
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        ProjectDetailView(project: Project(
            id: "1",
            title: "Modern Kitchen Renovation",
            status: "In Progress",
            tags: ["Kitchen", "Renovation"],
            description: "Complete kitchen remodel with new cabinets, countertops, and appliances.",
            imageUrl: nil,
            location: "123 Main St, San Francisco"
        ))
    }
}
