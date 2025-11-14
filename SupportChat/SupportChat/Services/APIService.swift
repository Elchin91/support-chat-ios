//
//  APIService.swift
//  SupportChat
//
//  Created on 11/14/2025.
//

import Foundation
import Combine

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
    
    // Publishers
    @Published var isConnected = false
    private var cancellables = Set<AnyCancellable>()
    
    // Session management
    private var sessionId: String?
    private var checkTimer: Timer?
    
    init() {
        // Get server URL from AppConfig
        self.baseURL = AppConfig.serverURL
        
        // Start connection check
        startConnectionCheck()
    }
    
    deinit {
        checkTimer?.invalidate()
    }
    
    // MARK: - Connection Management
    private func startConnectionCheck() {
        checkTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { [weak self] _ in
            self?.checkConnection()
        }
        checkConnection()
    }
    
    private func checkConnection() {
        guard let url = URL(string: "\(baseURL)/api/health") else { return }
        
        URLSession.shared.dataTask(with: url) { [weak self] _, response, error in
            DispatchQueue.main.async {
                if let httpResponse = response as? HTTPURLResponse,
                   httpResponse.statusCode == 200 {
                    self?.isConnected = true
                } else {
                    self?.isConnected = false
                }
            }
        }.resume()
    }
    
    func connect() {
        checkConnection()
    }
    
    func disconnect() {
        isConnected = false
        checkTimer?.invalidate()
    }
    
    // MARK: - Chat API
    func sendChatMessage(_ message: String) -> AnyPublisher<ChatResponse, Error> {
        return sendMessageViaREST(message)
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