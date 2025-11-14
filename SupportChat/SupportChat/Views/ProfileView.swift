//
//  ProfileView.swift
//  SupportChat
//
//  Created on 11/14/2025.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var appState: AppState
    @State private var showingSettings = false
    @State private var showingDocuments = false
    @State private var showingSupport = false
    @State private var selectedLanguage = "Русский"
    @State private var showingLogoutAlert = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 16) {
                    // Header
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Профиль")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        
                        Text(appState.phoneNumber)
                            .font(.system(size: 18))
                            .foregroundColor(.gray)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.top, 20)
                    
                    // Top Cards
                    HStack(spacing: 12) {
                        ProfileCard(
                            icon: "person.fill",
                            title: "Мои данные",
                            isVerified: true
                        ) {
                            // Handle tap
                        }
                        
                        ProfileCard(
                            icon: "qrcode",
                            title: "Мой QR",
                            isVerified: false
                        ) {
                            // Handle tap
                        }
                    }
                    .padding(.horizontal)
                    
                    // Menu Items
                    VStack(spacing: 0) {
                        MenuRow(
                            icon: "briefcase.fill",
                            title: "Ведите свой бизнес с m10"
                        ) {
                            // Handle tap
                        }
                        
                        Divider()
                            .padding(.leading, 64)
                        
                        MenuRow(
                            icon: "gearshape.fill",
                            title: "Настройки"
                        ) {
                            showingSettings = true
                        }
                        
                        Divider()
                            .padding(.leading, 64)
                        
                        MenuRow(
                            icon: "doc.text.fill",
                            title: "Документы"
                        ) {
                            showingDocuments = true
                        }
                        
                        Divider()
                            .padding(.leading, 64)
                        
                        MenuRow(
                            icon: "percent",
                            title: "Тарифы и лимиты"
                        ) {
                            // Handle tap
                        }
                        
                        Divider()
                            .padding(.leading, 64)
                        
                        MenuRow(
                            icon: "doc.on.doc.fill",
                            title: "Выписка со счета"
                        ) {
                            // Handle tap
                        }
                        
                        Divider()
                            .padding(.leading, 64)
                        
                        MenuRow(
                            icon: "headphones",
                            title: "Поддержка"
                        ) {
                            showingSupport = true
                        }
                        
                        Divider()
                            .padding(.leading, 64)
                        
                        LanguageRow(selectedLanguage: $selectedLanguage)
                        
                        Divider()
                            .padding(.leading, 64)
                        
                        MenuRow(
                            icon: "person.badge.plus",
                            title: "Карьера в PashaPay",
                            iconColor: .teal
                        ) {
                            // Handle tap
                        }
                    }
                    .background(Color.white)
                    .cornerRadius(16)
                    .padding(.horizontal)
                    
                    // Logout Button
                    Button(action: {
                        showingLogoutAlert = true
                    }) {
                        Text("Выйти из m10")
                            .font(.system(size: 16))
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 20)
                    .padding(.bottom, 100)
                }
            }
            .background(Color.gray.opacity(0.05))
            .navigationBarHidden(true)
            .sheet(isPresented: $showingSettings) {
                SettingsView()
            }
            .sheet(isPresented: $showingDocuments) {
                DocumentsView()
            }
            .sheet(isPresented: $showingSupport) {
                SupportView()
            }
            .alert("Выход", isPresented: $showingLogoutAlert) {
                Button("Отмена", role: .cancel) { }
                Button("Выйти", role: .destructive) {
                    // Handle logout
                }
            } message: {
                Text("Вы действительно хотите выйти?")
            }
        }
        .overlay(
            // Floating Chat Button
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    
                    Button(action: {
                        appState.selectedTab = 2 // Switch to AI chat
                    }) {
                        Image(systemName: "message.fill")
                            .font(.system(size: 28))
                            .foregroundColor(.white)
                            .frame(width: 64, height: 64)
                            .background(
                                LinearGradient(
                                    gradient: Gradient(colors: [Color.teal, Color.cyan]),
                                    startPoint: .topLeading,
                                    endPoint: .bottomTrailing
                                )
                            )
                            .clipShape(Circle())
                            .shadow(color: Color.black.opacity(0.3), radius: 10, x: 0, y: 5)
                    }
                    .padding(.trailing, 24)
                    .padding(.bottom, 100)
                }
            }
        )
    }
}

struct ProfileCard: View {
    let icon: String
    let title: String
    let isVerified: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 16) {
                ZStack(alignment: .bottomTrailing) {
                    Image(systemName: icon)
                        .font(.system(size: 24))
                        .foregroundColor(.white)
                        .frame(width: 56, height: 56)
                        .background(Color.indigo)
                        .clipShape(Circle())
                    
                    if isVerified {
                        Image(systemName: "checkmark.circle.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .background(Color.blue)
                            .clipShape(Circle())
                            .offset(x: 4, y: 4)
                    }
                }
                
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.primary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(24)
            .background(Color.gray.opacity(0.1))
            .cornerRadius(16)
        }
    }
}

struct MenuRow: View {
    let icon: String
    let title: String
    var iconColor: Color = .primary
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 24))
                    .foregroundColor(iconColor)
                    .frame(width: 32, height: 32)
                
                Text(title)
                    .font(.system(size: 16))
                    .foregroundColor(.primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
    }
}

struct LanguageRow: View {
    @Binding var selectedLanguage: String
    
    var body: some View {
        HStack(spacing: 16) {
            // Russian flag
            Image(systemName: "flag.fill")
                .font(.system(size: 24))
                .foregroundColor(.blue)
                .frame(width: 32, height: 32)
            
            VStack(alignment: .leading, spacing: 2) {
                Text("Язык")
                    .font(.system(size: 16))
                    .foregroundColor(.primary)
                
                Text(selectedLanguage)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .font(.system(size: 14))
                .foregroundColor(.gray)
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 16)
        .onTapGesture {
            // Handle language selection
        }
    }
}

// Additional Views
struct SettingsView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            List {
                Section("Безопасность") {
                    Label("Face ID / Touch ID", systemImage: "faceid")
                    Label("Изменить PIN-код", systemImage: "lock.fill")
                    Label("Двухфакторная аутентификация", systemImage: "lock.shield.fill")
                }
                
                Section("Уведомления") {
                    Toggle("Push-уведомления", isOn: .constant(true))
                    Toggle("Email-уведомления", isOn: .constant(false))
                    Toggle("SMS-уведомления", isOn: .constant(true))
                }
                
                Section("Приватность") {
                    Label("Управление данными", systemImage: "person.text.rectangle.fill")
                    Label("История активности", systemImage: "clock.arrow.circlepath")
                }
            }
            .navigationTitle("Настройки")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Готово") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct DocumentsView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "doc.text.fill")
                    .font(.system(size: 80))
                    .foregroundColor(.gray)
                    .padding(40)
                
                Text("Ваши документы")
                    .font(.title2)
                    .bold()
                
                Text("Здесь будут отображаться ваши договоры и документы")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .padding(.top, 8)
                
                Spacer()
            }
            .navigationTitle("Документы")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Готово") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct SupportView: View {
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image(systemName: "headphones")
                    .font(.system(size: 80))
                    .foregroundColor(.cyan)
                    .padding(40)
                
                Text("Служба поддержки")
                    .font(.title2)
                    .bold()
                
                VStack(spacing: 16) {
                    Button(action: {
                        dismiss()
                        // Switch to AI chat
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            appState.selectedTab = 2
                        }
                    }) {
                        Label("Чат с AI ассистентом", systemImage: "message.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.cyan)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    
                    Button(action: {}) {
                        Label("Позвонить в поддержку", systemImage: "phone.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                    
                    Button(action: {}) {
                        Label("Email поддержки", systemImage: "envelope.fill")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(12)
                    }
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .navigationTitle("Поддержка")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Готово") {
                        dismiss()
                    }
                }
            }
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
            .environmentObject(AppState())
    }
}
