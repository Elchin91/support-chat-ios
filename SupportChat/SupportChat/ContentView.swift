//
//  ContentView.swift
//  SupportChat
//
//  Created on 11/14/2025.
//

import SwiftUI

// Import all view files
struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        TabView(selection: $appState.selectedTab) {
            HomeView()
                .tabItem {
                    Label("Главная", systemImage: "house.fill")
                }
                .tag(0)
            
            PaymentsView()
                .tabItem {
                    Label("Платежи", systemImage: "creditcard.fill")
                }
                .tag(1)
            
            AIChatView()
                .tabItem {
                    Label("AI", systemImage: "message.fill")
                }
                .tag(2)
            
            HistoryView()
                .tabItem {
                    Label("История", systemImage: "clock.fill")
                }
                .tag(3)
            
            ProfileView()
                .tabItem {
                    Label("Профиль", systemImage: "person.fill")
                }
                .tag(4)
        }
    }
}
