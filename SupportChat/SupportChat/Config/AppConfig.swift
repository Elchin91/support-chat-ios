//
//  AppConfig.swift
//  SupportChat
//
//  Created on 11/14/2025.
//

import Foundation

struct AppConfig {
    // Server Configuration
    static let serverHost = ProcessInfo.processInfo.environment["SERVER_HOST"] ?? "localhost"
    static let serverPort = ProcessInfo.processInfo.environment["SERVER_PORT"] ?? "3000"
    static let serverURL = "http://\(serverHost):\(serverPort)"
    static let websocketURL = serverURL
    
    // API Endpoints
    struct API {
        static let chat = "/api/chat"
        static let telegramLink = "/api/telegram/link"
        static let userProfile = "/api/user/profile"
        static let transactions = "/api/transactions"
        static let balance = "/api/balance"
    }
    
    // WebSocket Events
    struct SocketEvents {
        static let connect = "connect"
        static let disconnect = "disconnect"
        static let userMessage = "user_message"
        static let aiResponse = "ai_response"
        static let error = "error"
        static let typing = "typing"
        static let stopTyping = "stop_typing"
    }
    
    // App Settings
    struct Settings {
        static let maxMessageLength = 1000
        static let connectionTimeout: TimeInterval = 30
        static let reconnectAttempts = 5
        static let reconnectDelay: TimeInterval = 2
    }
    
    // UI Configuration
    struct UI {
        static let primaryColor = "cyan"
        static let secondaryColor = "teal"
        static let accentColor = "blue"
        static let cornerRadius: Double = 16
        static let animationDuration: Double = 0.3
    }
    
    // Storage Keys
    struct StorageKeys {
        static let sessionId = "sessionId"
        static let userId = "userId"
        static let isFirstLaunch = "isFirstLaunch"
        static let language = "language"
        static let theme = "theme"
    }
}
