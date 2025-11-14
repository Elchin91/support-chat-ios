//
//  HomeView.swift
//  SupportChat
//
//  Created on 11/14/2025.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var appState: AppState
    @State private var showingQRCode = false
    
    var body: some View {
        ZStack {
            // Gradient background
            LinearGradient(
                gradient: Gradient(colors: [Color.cyan, Color.teal, Color.green.opacity(0.8)]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Status bar
                StatusBarView()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        // QR Code Header
                        HStack {
                            Image(systemName: "qrcode")
                                .font(.system(size: 28))
                                .frame(width: 48, height: 48)
                                .background(Color.white)
                                .cornerRadius(16)
                            
                            Text("Мой QR")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 16)
                        .onTapGesture {
                            showingQRCode = true
                        }
                        
                        // Balance Card
                        BalanceCard()
                            .padding(.horizontal, 16)
                        
                        // My Payments Card
                        MyPaymentsCard()
                            .padding(.horizontal, 16)
                        
                        // Promo Cards Scroll
                        PromoCardsScroll()
                        
                        // Services Section
                        VStack(alignment: .leading, spacing: 12) {
                            Text("НАШИ СЕРВИСЫ")
                                .font(.system(size: 12, weight: .semibold))
                                .foregroundColor(.gray)
                                .padding(.horizontal, 16)
                            
                            HStack(spacing: 12) {
                                // Credit Card
                                VStack(alignment: .leading, spacing: 8) {
                                    Text("Кредит до")
                                        .font(.system(size: 18, weight: .bold))
                                        .foregroundColor(.white)
                                    Text("25 000₼")
                                        .font(.system(size: 24, weight: .bold))
                                        .foregroundColor(.white)
                                    Spacer()
                                    Text("💵")
                                        .font(.system(size: 60))
                                        .offset(x: 40, y: -20)
                                }
                                .frame(maxWidth: .infinity, minHeight: 140)
                                .background(
                                    LinearGradient(
                                        gradient: Gradient(colors: [Color.blue.opacity(0.8), Color.blue]),
                                        startPoint: .topLeading,
                                        endPoint: .bottomTrailing
                                    )
                                )
                                .cornerRadius(24)
                                
                                // BakiKart Card
                                VStack {
                                    Text("BakiKart")
                                        .font(.system(size: 18, weight: .bold))
                                    
                                    HStack(spacing: 8) {
                                        Image(systemName: "heart.fill")
                                            .foregroundColor(.red)
                                            .font(.system(size: 20))
                                            .frame(width: 48, height: 48)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .stroke(Color.red, lineWidth: 4)
                                            )
                                        
                                        Image(systemName: "qrcode")
                                            .font(.system(size: 20))
                                            .frame(width: 48, height: 48)
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 12)
                                                    .stroke(Color.black, lineWidth: 4)
                                            )
                                    }
                                }
                                .frame(maxWidth: .infinity, minHeight: 140)
                                .background(Color.white)
                                .cornerRadius(24)
                            }
                            .padding(.horizontal, 16)
                        }
                    }
                    .padding(.top, 16)
                    .padding(.bottom, 100)
                }
            }
        }
        .sheet(isPresented: $showingQRCode) {
            QRCodeView()
        }
    }
}

struct StatusBarView: View {
    var body: some View {
        HStack {
            HStack(spacing: 4) {
                Text("06:27")
                    .font(.system(size: 14, weight: .semibold))
                Image(systemName: "location.north.fill")
                    .font(.system(size: 12))
            }
            
            Spacer()
            
            HStack(spacing: 8) {
                Image(systemName: "antenna.radiowaves.left.and.right")
                    .font(.system(size: 14))
                Image(systemName: "wifi")
                    .font(.system(size: 14))
                
                Text("100")
                    .font(.system(size: 12, weight: .bold))
                    .padding(.horizontal, 8)
                    .padding(.vertical, 2)
                    .background(Color.white)
                    .foregroundColor(.black)
                    .cornerRadius(4)
            }
        }
        .foregroundColor(.white)
        .padding(.horizontal, 16)
        .padding(.top, 50)
        .padding(.bottom, 16)
    }
}

struct BalanceCard: View {
    @EnvironmentObject var appState: AppState
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Доступно")
                .font(.system(size: 14))
                .foregroundColor(.gray)
            
            HStack(alignment: .bottom) {
                HStack(alignment: .bottom, spacing: 4) {
                    Text(appState.isBalanceHidden ? "••" : String(format: "%.0f", appState.userBalance))
                        .font(.system(size: 48, weight: .bold))
                    
                    if !appState.isBalanceHidden {
                        Text(String(format: ".%02d", Int((appState.userBalance * 100).truncatingRemainder(dividingBy: 100))))
                            .font(.system(size: 32))
                            .foregroundColor(.gray)
                    }
                    
                    Text("₼")
                        .font(.system(size: 24))
                        .foregroundColor(.gray)
                        .padding(.bottom, 6)
                }
                
                Spacer()
                
                Button(action: {
                    withAnimation {
                        appState.isBalanceHidden.toggle()
                    }
                }) {
                    Image(systemName: appState.isBalanceHidden ? "eye.slash.fill" : "eye.fill")
                        .foregroundColor(.gray)
                        .frame(width: 40, height: 40)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(Circle())
                }
            }
            
            HStack(spacing: 12) {
                Button(action: {}) {
                    Label("Пополнить", systemImage: "plus")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.black)
                        .cornerRadius(16)
                }
                
                Button(action: {}) {
                    Label("Перевести", systemImage: "arrow.up.right")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 16)
                        .background(Color.black)
                        .cornerRadius(16)
                }
            }
        }
        .padding(24)
        .background(Color.white)
        .cornerRadius(24)
        .shadow(color: Color.black.opacity(0.1), radius: 10)
    }
}

struct MyPaymentsCard: View {
    var body: some View {
        HStack {
            Image(systemName: "doc.text.fill")
                .font(.system(size: 30))
                .foregroundColor(.blue)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Мои платежи")
                    .font(.system(size: 18, weight: .bold))
                Text("8 сохраненных платежей")
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(20)
        .background(Color.white)
        .cornerRadius(24)
        .shadow(color: Color.black.opacity(0.1), radius: 10)
    }
}

struct PromoCardsScroll: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                PromoCard(
                    title: "Пожертвование в фонд\n«YAŞAT»",
                    emoji: "💛",
                    backgroundColor: Color.blue.opacity(0.9),
                    borderColor: Color.blue.opacity(0.7)
                )
                
                PromoCard(
                    title: "Скоро!\nПереводы за\nграницу",
                    emoji: "🐋",
                    backgroundColor: Color.white,
                    borderColor: Color.blue.opacity(0.4)
                )
                
                PromoCard(
                    title: "Лотерея\nBirmarket",
                    emoji: "💎",
                    backgroundColor: LinearGradient(
                        gradient: Gradient(colors: [Color.pink.opacity(0.8), Color.pink]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    borderColor: Color.pink.opacity(0.4)
                )
                
                PromoCard(
                    title: "Переводы в\nРоссию",
                    emoji: "💸",
                    backgroundColor: LinearGradient(
                        gradient: Gradient(colors: [Color.green.opacity(0.6), Color.green.opacity(0.3)]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    ),
                    borderColor: Color.green.opacity(0.4)
                )
            }
            .padding(.horizontal, 16)
        }
    }
}

struct PromoCard<Background: View>: View {
    let title: String
    let emoji: String
    let backgroundColor: Background
    let borderColor: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(backgroundColor is Color && (backgroundColor as! Color) == Color.white ? .black : .white)
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            Text(emoji)
                .font(.system(size: 40))
        }
        .padding(16)
        .frame(width: 160, height: 140)
        .background(backgroundColor)
        .cornerRadius(24)
        .overlay(
            RoundedRectangle(cornerRadius: 24)
                .stroke(borderColor, lineWidth: 4)
        )
    }
}

struct QRCodeView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "qrcode")
                    .font(.system(size: 200))
                    .padding(40)
                
                Text("Ваш QR код")
                    .font(.title2)
                    .bold()
            }
            .navigationTitle("Мой QR")
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

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .environmentObject(AppState())
    }
}
