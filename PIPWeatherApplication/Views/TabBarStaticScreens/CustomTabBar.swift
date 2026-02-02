//
//  CustomTabBar.swift
//  PIPWeatherApplication
//
//  Created by a.unmesh.kalamkar on 27/01/26.
//

import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedTab: TabItem
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(TabItem.allCases, id: \.self) { tab in
                tabButton(for: tab)
            }
        }
        .padding(.horizontal, 8)
        .padding(.top, 8)
        .padding(.bottom, 20)
        .background(
            colorScheme == .dark ? Color.tabBarBackgroundDark : Color.tabBarBackground
        )
        .shadow(color: .black.opacity(0.1), radius: 10, x: 0, y: -5)
    }
    
    private func tabButton(for tab: TabItem) -> some View {
        Button(action: {
            withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                selectedTab = tab
            }
        }) {
            VStack(spacing: 4) {
                Image(systemName: selectedTab == tab ? tab.icon : tab.inactiveIcon)
                    .font(.system(size: 24))
                    .foregroundColor(selectedTab == tab ? .tabBarSelected : .tabBarUnselected)
                    .scaleEffect(selectedTab == tab ? 1.1 : 1.0)
                
                Text(tab.title)
                    .font(.tabBarFont)
                    .foregroundColor(selectedTab == tab ? .tabBarSelected : .tabBarUnselected)
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 8)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    VStack {
        Spacer()
        CustomTabBar(selectedTab: .constant(.today))
    }
}
