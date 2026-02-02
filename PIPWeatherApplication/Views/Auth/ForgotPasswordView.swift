//
//  ForgotPasswordView.swift
//  PIPWeatherApplication
//
//  Created by a.unmesh.kalamkar on 27/01/26.
//

import SwiftUI

struct ForgotPasswordView: View {
    @Environment(\.dismiss) var dismiss
    @State private var email: String = ""
    @State private var isLoading: Bool = false
    @State private var showSuccess: Bool = false
    
    var body: some View {
        ZStack {
            Color.backgroundLight
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    Spacer(minLength: 40)
                    
                    // Icon
                    Image(systemName: "lock.shield.fill")
                        .font(.system(size: 80))
                        .foregroundColor(.greenTagPrimary)
                        .padding(.bottom, 8)
                    
                    // Title
                    VStack(spacing: 8) {
                        Text("Forgot Password?")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.textPrimary)
                        
                        Text("Enter your email to receive a reset link")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.textSecondary)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 32)
                    }
                    .padding(.bottom, 32)
                    
                    // Email field
                    TextField("", text: $email)
                        .placeholder(when: email.isEmpty) {
                            Text("Enter your email")
                                .foregroundColor(.textTertiary)
                        }
                        .padding()
                        .background(Color.white)
                        .cornerRadius(12)
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.borderLight, lineWidth: 1)
                        )
                        .autocapitalization(.none)
                        .keyboardType(.emailAddress)
                        .padding(.horizontal, 24)
                    
                    // Send button
                    Button(action: {
                        sendResetLink()
                    }) {
                        HStack {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            } else {
                                Text("Send Reset Link")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.buttonPrimary)
                        .cornerRadius(12)
                    }
                    .disabled(isLoading || email.isEmpty)
                    .opacity((isLoading || email.isEmpty) ? 0.6 : 1.0)
                    .padding(.horizontal, 24)
                    .padding(.top, 8)
                    
                    // Back to login
                    Button(action: {
                        dismiss()
                    }) {
                        Text("Back to Login")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.greenTagPrimary)
                    }
                    .padding(.top, 16)
                    
                    Spacer()
                }
            }
            
            // Success overlay
            if showSuccess {
                Color.black.opacity(0.4)
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.greenTagPrimary)
                    
                    Text("Email Sent!")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.textPrimary)
                    
                    Text("Check your inbox for the password reset link")
                        .font(.system(size: 16))
                        .foregroundColor(.textSecondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 40)
                    
                    Button(action: {
                        showSuccess = false
                        dismiss()
                    }) {
                        Text("OK")
                            .font(.system(size: 16, weight: .semibold))
                            .foregroundColor(.white)
                            .frame(width: 120, height: 44)
                            .background(Color.greenTagPrimary)
                            .cornerRadius(8)
                    }
                    .padding(.top, 8)
                }
                .padding(32)
                .background(Color.white)
                .cornerRadius(20)
                .shadow(radius: 20)
                .padding(.horizontal, 40)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private func sendResetLink() {
        isLoading = true
        
        // Simulate API call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            isLoading = false
            showSuccess = true
        }
    }
}

#Preview {
    NavigationStack {
        ForgotPasswordView()
    }
}
