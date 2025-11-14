//
//  SupportChatApp.swift
//  SupportChat
//
//  Created on 11/14/2025.
//

import SwiftUI

@main
struct SupportChatApp: App {
    @StateObject private var appState = AppState()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appState)
                .preferredColorScheme(.light)
                .tint(Color.cyan)
        }
    }
}

// Global app state manager
class AppState: ObservableObject {
    @Published var selectedTab = 0
    @Published var isLoggedIn = true // For now, we assume user is logged in
    @Published var userBalance: Double = 39.57
    @Published var isBalanceHidden = false
    
    // User info
    @Published var phoneNumber = "+994 50 519 99 91"
    @Published var userName = "User"
}
