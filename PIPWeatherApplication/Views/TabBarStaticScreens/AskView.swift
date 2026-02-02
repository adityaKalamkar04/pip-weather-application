//
//  AskView.swift
//  PIPWeatherApplication
//
//  Created by a.unmesh.kalamkar on 27/01/26.
//

import SwiftUI

struct AskView: View {
    @State private var question: String = ""
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                    .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header
                headerView
                
                // Content
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        Text("Ask")
                            .font(.system(size: 34, weight: .bold))
                            .foregroundColor(.textPrimary)
                            .padding(.horizontal)
                            .padding(.top, 16)
                        
                        Text("Get instant answers about your concrete projects, timing, and best practices.")
                            .font(.system(size: 16))
                            .foregroundColor(.textSecondary)
                            .padding(.horizontal)
                        
                        // Question input
                        VStack(alignment: .leading, spacing: 12) {
                            TextField("Type your question here...", text: $question, axis: .vertical)
                                .lineLimit(5...10)
                                .padding()
                                .background(Color.white)
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.borderLight, lineWidth: 1)
                                )
                            
                            Button(action: {
                                // Submit question
                                submitQuestion()
                            }) {
                                Text("Ask Question")
                                    .font(.system(size: 16, weight: .semibold))
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 48)
                                    .background(Color.buttonPrimary)
                                    .cornerRadius(12)
                            }
                            .disabled(question.isEmpty)
                            .opacity(question.isEmpty ? 0.5 : 1.0)
                        }
                        .padding(.horizontal)
                        
                        // Suggested questions
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Suggested Questions")
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundColor(.textPrimary)
                            
                            ForEach(suggestedQuestions, id: \.self) { question in
                                Button(action: {
                                    self.question = question
                                }) {
                                    HStack {
                                        Text(question)
                                            .font(.system(size: 15))
                                            .foregroundColor(.textPrimary)
                                            .multilineTextAlignment(.leading)
                                        
                                        Spacer()
                                        
                                        Image(systemName: "arrow.right")
                                            .font(.system(size: 14))
                                            .foregroundColor(.textSecondary)
                                    }
                                    .padding()
                                    .background(Color.white)
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(Color.borderLight, lineWidth: 1)
                                    )
                                }
                            }
                        }
                        .padding(.horizontal)
                        .padding(.top, 20)
                    }
                    .padding(.bottom, 20)
                }
            }
            .navigationBarHidden(true)
        }
        }
    }
    
    // MARK: - Subviews
    
    private var headerView: some View {
        HStack {
            // User avatar
            Image(systemName: "person.circle.fill")
                .font(.system(size: 40))
                .foregroundColor(.greenTagPrimary)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Welcome back")
                    .font(.system(size: 13))
                    .foregroundColor(.textSecondary)
                
                Text("Aditya Kalamkar")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.textPrimary)
            }
            
            Spacer()
            
            // Notification bell
            NavigationLink(destination: NotificationDetailView(notification: getDefaultNotification())) {
                ZStack(alignment: .topTrailing) {
                    Image(systemName: "bell")
                        .font(.system(size: 22))
                        .foregroundColor(.textPrimary)
                    
                    // Notification badge
                    Circle()
                        .fill(Color.greenTagNotification)
                        .frame(width: 8, height: 8)
                        .offset(x: 4, y: -4)
                }
                .frame(width: 44, height: 44)
            }
            
            // Search button
            Button(action: {
                // Search action
            }) {
                Image(systemName: "magnifyingglass")
                    .font(.system(size: 22))
                    .foregroundColor(.textPrimary)
                    .frame(width: 44, height: 44)
            }
        }
        .padding(.horizontal)
        .padding(.top, 8)
    }
    
    private var suggestedQuestions: [String] {
        [
            "How long should I wait before walking on freshly poured concrete?",
            "What's the ideal temperature for pouring concrete?",
            "How often should I water new concrete?",
            "When can I remove the forms from my concrete?"
        ]
    }
    
    private func submitQuestion() {
        DeviceDetector.log("Question submitted: \(question)", type: .info)
        // Handle question submission
    }
    
    private func getDefaultNotification() -> AppNotification {
        return AppNotification(
            id: "default",
            title: "Notification Center",
            message: "This is where you'll see all your important notifications and updates about your projects.",
            time: "Now",
            isUrgent: false,
            icon: "bell.fill"
        )
    }
}

#Preview {
    AskView()
}
