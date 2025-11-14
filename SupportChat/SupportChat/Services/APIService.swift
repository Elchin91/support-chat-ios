//
//  APIService.swift
//  SupportChat
//
//  Created on 11/14/2025.
//

import Foundation
import Combine
import SocketIO

// API Response Models
struct ChatResponse: Codable {
    let content: String
    let timestamp: Date?
    let sessionId: String?
}

struct ErrorResponse: Codable {
    let error: String
    let message: String
}

// API Service
class APIService: ObservableObject {
    static let shared = APIService()
    
    // Configuration
    private let baseURL: String
    private let socketURL: String
    private var socketManager: SocketManager?
    private var socket: SocketIOClient?
    
    // Publishers
    @Published var isConnected = false
    private var cancellables = Set<AnyCancellable>()
    
    // Session management
    private var sessionId: String?
    
    init() {
        // Get server URL from config or use default
        let serverHost = ProcessInfo.processInfo.environment["SERVER_HOST"] ?? "localhost"
        let serverPort = ProcessInfo.processInfo.environment["SERVER_PORT"] ?? "3000"
        
        self.baseURL = "http://\(serverHost):\(serverPort)"
        self.socketURL = self.baseURL
        
        setupSocketConnection()
    }
    
    // MARK: - Socket.IO Setup
    private func setupSocketConnection() {
        guard let url = URL(string: socketURL) else { return }
        
        socketManager = SocketManager(
            socketURL: url,
            config: [
                .log(false),
                .compress,
                .reconnects(true),
                .reconnectAttempts(5),
                .reconnectWait(2)
            ]
        )
        
        socket = socketManager?.defaultSocket
        
        // Setup socket event handlers
        socket?.on(clientEvent: .connect) { [weak self] _, _ in
            DispatchQueue.main.async {
                self?.isConnected = true
                print("Socket connected")
            }
        }
        
        socket?.on(clientEvent: .disconnect) { [weak self] _, _ in
            DispatchQueue.main.async {
                self?.isConnected = false
                print("Socket disconnected")
            }
        }
        
        socket?.on("ai_response") { [weak self] data, _ in
            guard let responseData = data.first as? [String: Any],
                  let content = responseData["content"] as? String else { return }
            
            // Handle AI response through socket
            print("Received AI response: \(content)")
        }
        
        socket?.on("error") { data, _ in
            if let error = data.first as? String {
                print("Socket error: \(error)")
            }
        }
    }
    
    // MARK: - Connection Management
    func connect() {
        socket?.connect()
    }
    
    func disconnect() {
        socket?.disconnect()
    }
    
    // MARK: - Chat API
    func sendChatMessage(_ message: String) -> AnyPublisher<ChatResponse, Error> {
        // First, try to send via socket if connected
        if isConnected {
            return sendMessageViaSocket(message)
        } else {
            // Fallback to REST API
            return sendMessageViaREST(message)
        }
    }
    
    private func sendMessageViaSocket(_ message: String) -> AnyPublisher<ChatResponse, Error> {
        return Future<ChatResponse, Error> { [weak self] promise in
            guard let self = self, let socket = self.socket else {
                promise(.failure(APIError.notConnected))
                return
            }
            
            let messageData: [String: Any] = [
                "content": message,
                "sessionId": self.sessionId ?? UUID().uuidString,
                "timestamp": Date().timeIntervalSince1970
            ]
            
            // Setup one-time response handler
            socket.once("ai_response") { data, _ in
                if let responseData = data.first as? [String: Any],
                   let content = responseData["content"] as? String {
                    let response = ChatResponse(
                        content: content,
                        timestamp: Date(),
                        sessionId: responseData["sessionId"] as? String
                    )
                    promise(.success(response))
                } else {
                    promise(.failure(APIError.invalidResponse))
                }
            }
            
            // Send message
            socket.emit("user_message", messageData)
            
            // Timeout handling
            DispatchQueue.main.asyncAfter(deadline: .now() + 30) {
                promise(.failure(APIError.timeout))
            }
        }
        .eraseToAnyPublisher()
    }
    
    private func sendMessageViaREST(_ message: String) -> AnyPublisher<ChatResponse, Error> {
        guard let url = URL(string: "\(baseURL)/api/chat") else {
            return Fail(error: APIError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "message": message,
            "sessionId": sessionId ?? UUID().uuidString,
            "platform": "ios"
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        } catch {
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      (200...299).contains(httpResponse.statusCode) else {
                    throw APIError.serverError
                }
                return data
            }
            .decode(type: ChatResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .handleEvents(receiveOutput: { [weak self] response in
                // Save session ID if provided
                if let sessionId = response.sessionId {
                    self?.sessionId = sessionId
                }
            })
            .eraseToAnyPublisher()
    }
    
    // MARK: - Telegram Integration
    func linkTelegramAccount(userId: String) -> AnyPublisher<Bool, Error> {
        guard let url = URL(string: "\(baseURL)/api/telegram/link") else {
            return Fail(error: APIError.invalidURL)
                .eraseToAnyPublisher()
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = ["userId": userId, "sessionId": sessionId ?? ""]
        request.httpBody = try? JSONEncoder().encode(body)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { _, response in
                guard let httpResponse = response as? HTTPURLResponse,
                      httpResponse.statusCode == 200 else {
                    throw APIError.serverError
                }
                return true
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

// MARK: - API Errors
enum APIError: LocalizedError {
    case invalidURL
    case invalidResponse
    case serverError
    case notConnected
    case timeout
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Неверный URL сервера"
        case .invalidResponse:
            return "Неверный ответ от сервера"
        case .serverError:
            return "Ошибка сервера"
        case .notConnected:
            return "Нет подключения к серверу"
        case .timeout:
            return "Превышено время ожидания"
        }
    }
}
