//
//  LoginView.swift
//  PIPWeatherApplication
//
//  Created by a.unmesh.kalamkar on 27/01/26.
//

import SwiftUI

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showPassword: Bool = false
    @State private var isLoading: Bool = false
    @State private var showForgotPassword: Bool = false
    @State private var emailError: String = ""
    @State private var passwordError: String = ""
    @State private var showErrorAlert: Bool = false
    @State private var errorMessage: String = ""
    @Binding var isLoggedIn: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
            // Background
            Color.backgroundLight
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 24) {
                    Spacer(minLength: 60)
                    
                    // Back button
                    HStack {
                        Button(action: {
                            // Back action
                        }) {
                            Image(systemName: "arrow.left")
                                .font(.system(size: 24))
                                .foregroundColor(.textPrimary)
                        }
                        Spacer()
                    }
                    .padding(.horizontal)
                    
                    Spacer(minLength: 40)
                    
                    // Logo
                    Image(systemName: "sun.snow")
                        .font(.system(size: 80))
                        .foregroundColor(.greenTagPrimary)
                        .padding(.bottom, 8)
                    
                    Text("Weather App")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(.textPrimary)
                        .padding(.bottom, 24)
                    
                    // Welcome text
                    VStack(spacing: 8) {
                        Text("Welcome back")
                            .font(.system(size: 32, weight: .bold))
                            .foregroundColor(.textPrimary)
                        
                        Text("Glad to see you again!")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.textSecondary)
                    }
                    .padding(.bottom, 32)
                    
                    // Email field
                    VStack(spacing: 16) {
                        VStack(alignment: .leading, spacing: 8) {
                            TextField("", text: $email)
                                .placeholder(when: email.isEmpty) {
                                    Text("fullname@email.com")
                                        .foregroundColor(.textTertiary)
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(12)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(emailError.isEmpty ? Color.borderLight : Color.red, lineWidth: emailError.isEmpty ? 1 : 2)
                                )
                                .autocapitalization(.none)
                                .keyboardType(.emailAddress)
                                .onChange(of: email) { _ in
                                    if !emailError.isEmpty {
                                        emailError = ""
                                    }
                                }
                            
                            if !emailError.isEmpty {
                                HStack(spacing: 4) {
                                    Image(systemName: "exclamationmark.circle.fill")
                                        .font(.system(size: 12))
                                        .foregroundColor(.red)
                                    Text(emailError)
                                        .font(.system(size: 12))
                                        .foregroundColor(.red)
                                }
                                .padding(.horizontal, 4)
                            }
                        }
                        
                        // Password field
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                if showPassword {
                                    TextField("", text: $password)
                                        .placeholder(when: password.isEmpty) {
                                            Text("Password")
                                                .foregroundColor(.textTertiary)
                                        }
                                } else {
                                    SecureField("", text: $password)
                                        .placeholder(when: password.isEmpty) {
                                            Text("Password")
                                                .foregroundColor(.textTertiary)
                                        }
                                }
                                
                                Button(action: {
                                    showPassword.toggle()
                                }) {
                                    Image(systemName: showPassword ? "eye.fill" : "eye")
                                        .foregroundColor(.textSecondary)
                                }
                            }
                            .padding()
                            .background(Color.white)
                            .cornerRadius(12)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(passwordError.isEmpty ? Color.borderGreen : Color.red, lineWidth: 2)
                            )
                            .onChange(of: password) { _ in
                                if !passwordError.isEmpty {
                                    passwordError = ""
                                }
                            }
                            
                            if !passwordError.isEmpty {
                                HStack(spacing: 4) {
                                    Image(systemName: "exclamationmark.circle.fill")
                                        .font(.system(size: 12))
                                        .foregroundColor(.red)
                                    Text(passwordError)
                                        .font(.system(size: 12))
                                        .foregroundColor(.red)
                                }
                                .padding(.horizontal, 4)
                            }
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    // Forgot password
                    HStack {
                        Spacer()
                        NavigationLink(destination: ForgotPasswordView()) {
                            Text("Forgot Password?")
                                .font(.system(size: 14))
                                .foregroundColor(.textPrimary)
                        }
                    }
                    .padding(.horizontal, 24)
                    
                    // Log in button
                    Button(action: {
                        login()
                    }) {
                        HStack {
                            if isLoading {
                                ProgressView()
                                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                            } else {
                                Text("Log In")
                                    .font(.system(size: 18, weight: .semibold))
                                    .foregroundColor(.white)
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.buttonPrimary)
                        .cornerRadius(12)
                    }
                    .disabled(isLoading)
                    .padding(.horizontal, 24)
                    .padding(.top, 8)
                    
                    Spacer()
                }
            }
            .navigationBarHidden(true)
            .alert("Login Error", isPresented: $showErrorAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(errorMessage)
            }
        }
        }
    }
    
    // MARK: - Validation
    
    private func validateFields() -> Bool {
        var isValid = true
        
        // Reset errors
        emailError = ""
        passwordError = ""
        
        // Validate email
        if email.trimmingCharacters(in: .whitespaces).isEmpty {
            emailError = "Email is required"
            isValid = false
        } else if !isValidEmail(email) {
            emailError = "Please enter a valid email address"
            isValid = false
        }
        
        // Validate password
        if password.isEmpty {
            passwordError = "Password is required"
            isValid = false
        } else if password.count < 6 {
            passwordError = "Password must be at least 6 characters"
            isValid = false
        }
        
        return isValid
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    private func login() {
        // Validate fields first
        guard validateFields() else {
            errorMessage = "Please fix the errors and try again"
            showErrorAlert = true
            return
        }
        
        isLoading = true
        
        // Simulate login
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            isLoading = false
            isLoggedIn = true
        }
    }
}

#Preview {
    LoginView(isLoggedIn: .constant(false))
}
