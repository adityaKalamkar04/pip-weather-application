//
//  View+Extension.swift
//  PIPWeatherApplication
//
//  Created by a.unmesh.kalamkar on 30/01/26.
//

import SwiftUI
import UIKit

extension View {
    /// Apply card style with shadow and background
    func cardStyle(backgroundColor: Color = .cardBackground) -> some View {
        self
            .background(backgroundColor)
            .cornerRadius(AppConstants.Layout.cornerRadius)
            .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
    
    /// Apply custom padding
    func customPadding(_ edges: Edge.Set = .all, _ length: CGFloat? = nil) -> some View {
        self.padding(edges, length ?? AppConstants.Layout.padding)
    }
    
    /// Conditional modifier
    @ViewBuilder
    func `if`<Transform: View>(_ condition: Bool, transform: (Self) -> Transform) -> some View {
        if condition {
            transform(self)
        } else {
            self
        }
    }
    
    /// Debug print helper
    func debugPrint(_ value: Any) -> some View {
        #if DEBUG
        print(value)
        #endif
        return self
    }
    
    /// Hide conditionally
    @ViewBuilder
    func hidden(_ shouldHide: Bool) -> some View {
        if shouldHide {
            self.hidden()
        } else {
            self
        }
    }
    
    /// Apply blur background
    func blurBackground(style: UIBlurEffect.Style = .systemMaterial) -> some View {
        self.background(BlurView(style: style))
    }
    
    /// TextField placeholder modifier
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content
    ) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}

// MARK: - Blur View Helper
struct BlurView: UIViewRepresentable {
    let style: UIBlurEffect.Style
    
    func makeUIView(context: Context) -> UIVisualEffectView {
        let view = UIVisualEffectView(effect: UIBlurEffect(style: style))
        return view
    }
    
    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        uiView.effect = UIBlurEffect(style: style)
    }
}
