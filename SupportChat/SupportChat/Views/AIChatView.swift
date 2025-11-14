//
//  AIChatView.swift
//  SupportChat
//
//  Created on 11/14/2025.
//

import SwiftUI
import Combine

struct AIChatView: View {
    @StateObject private var viewModel = AIChatViewModel()
    @State private var messageText = ""
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Messages list
                ScrollViewReader { scrollView in
                    ScrollView {
                        VStack(spacing: 12) {
                            // Welcome message
                            if viewModel.messages.isEmpty {
                                WelcomeMessageView()
                                    .padding(.top, 40)
                            }
                            
                            // Chat messages
                            ForEach(viewModel.messages) { message in
                                MessageBubble(message: message)
                                    .id(message.id)
                            }
                            
                            // Typing indicator
                            if viewModel.isTyping {
                                TypingIndicator()
                                    .id("typing")
                            }
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 20)
                    }
                    .onChange(of: viewModel.messages.count) { _ in
                        withAnimation {
                            scrollView.scrollTo(viewModel.messages.last?.id ?? "typing", anchor: .bottom)
                        }
                    }
                }
                .background(Color.gray.opacity(0.05))
                
                // Input area
                MessageInputView(
                    messageText: $messageText,
                    isTextFieldFocused: $isTextFieldFocused,
                    onSend: {
                        if !messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            viewModel.sendMessage(messageText)
                            messageText = ""
                        }
                    }
                )
            }
            .navigationTitle("AI Ассистент")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Menu {
                        Button(action: { viewModel.clearChat() }) {
                            Label("Очистить чат", systemImage: "trash")
                        }
                        Button(action: { viewModel.toggleConnectionStatus() }) {
                            Label(
                                viewModel.isConnected ? "Отключиться" : "Подключиться",
                                systemImage: viewModel.isConnected ? "wifi.slash" : "wifi"
                            )
                        }
                    } label: {
                        Image(systemName: "ellipsis.circle")
                    }
                }
            }
            .alert("Ошибка", isPresented: $viewModel.showError) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage)
            }
        }
    }
}

struct WelcomeMessageView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "message.badge.filled.fill")
                .font(.system(size: 60))
                .foregroundColor(.cyan)
            
            Text("Привет! Я AI ассистент")
                .font(.title2)
                .fontWeight(.bold)
            
            Text("Я помогу вам с любыми вопросами по работе сервиса, платежам, переводам и другим операциям.")
                .font(.body)
                .multilineTextAlignment(.center)
                .foregroundColor(.gray)
                .padding(.horizontal, 20)
            
            VStack(alignment: .leading, spacing: 12) {
                Text("Попробуйте спросить:")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(.gray)
                
                ForEach(suggestedQuestions, id: \.self) { question in
                    SuggestionChip(text: question)
                }
            }
            .padding(.top, 20)
        }
    }
    
    let suggestedQuestions = [
        "Как пополнить баланс?",
        "Как сделать перевод?",
        "Где посмотреть историю операций?",
        "Как изменить лимиты?"
    ]
}

struct SuggestionChip: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.system(size: 14))
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color.cyan.opacity(0.1))
            .foregroundColor(.cyan)
            .cornerRadius(20)
    }
}

struct MessageBubble: View {
    let message: ChatMessage
    
    var body: some View {
        HStack {
            if message.isUser { Spacer() }
            
            VStack(alignment: message.isUser ? .trailing : .leading, spacing: 4) {
                Text(message.content)
                    .font(.body)
                    .foregroundColor(message.isUser ? .white : .primary)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
                    .background(
                        message.isUser 
                            ? Color.cyan 
                            : Color.white
                    )
                    .cornerRadius(20)
                    .shadow(
                        color: message.isUser ? .clear : Color.black.opacity(0.05),
                        radius: 5
                    )
                
                Text(message.timestamp, style: .time)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: UIScreen.main.bounds.width * 0.75, alignment: message.isUser ? .trailing : .leading)
            
            if !message.isUser { Spacer() }
        }
    }
}

struct TypingIndicator: View {
    @State private var animationAmount = 0.0
    
    var body: some View {
        HStack {
            HStack(spacing: 4) {
                ForEach(0..<3) { index in
                    Circle()
                        .fill(Color.gray)
                        .frame(width: 8, height: 8)
                        .scaleEffect(animationAmount)
                        .opacity(animationAmount)
                        .animation(
                            .easeInOut(duration: 0.6)
                                .repeatForever(autoreverses: true)
                                .delay(Double(index) * 0.2),
                            value: animationAmount
                        )
                }
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.05), radius: 5)
            
            Spacer()
        }
        .onAppear {
            animationAmount = 1.0
        }
    }
}

struct MessageInputView: View {
    @Binding var messageText: String
    var isTextFieldFocused: FocusState<Bool>.Binding
    let onSend: () -> Void
    
    var body: some View {
        HStack(spacing: 12) {
            TextField("Введите сообщение...", text: $messageText)
                .textFieldStyle(PlainTextFieldStyle())
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(Color.white)
                .cornerRadius(25)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
                .focused(isTextFieldFocused)
                .onSubmit {
                    onSend()
                }
            
            Button(action: onSend) {
                Image(systemName: "arrow.up.circle.fill")
                    .font(.system(size: 36))
                    .foregroundColor(messageText.isEmpty ? .gray : .cyan)
            }
            .disabled(messageText.isEmpty)
        }
        .padding(.horizontal)
        .padding(.vertical, 12)
        .background(Color.gray.opacity(0.05))
    }
}

// Chat Message Model
struct ChatMessage: Identifiable {
    let id = UUID()
    let content: String
    let isUser: Bool
    let timestamp: Date
}

// ViewModel for AI Chat
class AIChatViewModel: ObservableObject {
    @Published var messages: [ChatMessage] = []
    @Published var isTyping = false
    @Published var isConnected = true
    @Published var showError = false
    @Published var errorMessage = ""
    
    private let apiService = APIService.shared
    private var cancellables = Set<AnyCancellable>()
    
    func sendMessage(_ text: String) {
        // Add user message
        let userMessage = ChatMessage(content: text, isUser: true, timestamp: Date())
        messages.append(userMessage)
        
        // Show typing indicator
        isTyping = true
        
        // Send to API
        apiService.sendChatMessage(text)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isTyping = false
                    if case .failure(let error) = completion {
                        self?.showError = true
                        self?.errorMessage = "Не удалось отправить сообщение: \(error.localizedDescription)"
                    }
                },
                receiveValue: { [weak self] response in
                    let aiMessage = ChatMessage(
                        content: response.content,
                        isUser: false,
                        timestamp: Date()
                    )
                    self?.messages.append(aiMessage)
                }
            )
            .store(in: &cancellables)
    }
    
    func clearChat() {
        messages.removeAll()
    }
    
    func toggleConnectionStatus() {
        isConnected.toggle()
        if isConnected {
            apiService.connect()
        } else {
            apiService.disconnect()
        }
    }
}

struct AIChatView_Previews: PreviewProvider {
    static var previews: some View {
        AIChatView()
    }
}
