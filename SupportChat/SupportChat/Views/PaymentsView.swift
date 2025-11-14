//
//  PaymentsView.swift
//  SupportChat
//
//  Created on 11/14/2025.
//

import SwiftUI

struct PaymentsView: View {
    @State private var searchText = ""
    @State private var selectedCategory: PaymentCategory? = nil
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Main content
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        // New Services
                        NewServicesSection()
                        
                        // My Payments
                        MyPaymentsSection()
                        
                        // Service Categories
                        ServiceCategoriesSection(selectedCategory: $selectedCategory)
                    }
                    .padding(.bottom, 100)
                }
                .background(Color.gray.opacity(0.05))
            }
            .navigationTitle("Сервисы")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "magnifyingglass")
                            .font(.system(size: 20))
                            .foregroundColor(.primary)
                    }
                }
            }
        }
        .sheet(item: $selectedCategory) { category in
            CategoryDetailView(category: category)
        }
    }
}

struct NewServicesSection: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 12) {
                NewServiceCard(
                    title: "Мой\nгараж",
                    badge: "Новинка",
                    imageName: "car.fill",
                    imageColor: .blue
                )
                
                NewServiceCard(
                    title: "Кабинет\nAzeriqaz",
                    badge: "Новинка",
                    imageName: "gauge.high",
                    imageColor: .orange
                )
            }
            .padding(.horizontal)
        }
    }
}

struct NewServiceCard: View {
    let title: String
    let badge: String
    let imageName: String
    let imageColor: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(badge)
                .font(.system(size: 12, weight: .semibold))
                .foregroundColor(.white)
                .padding(.horizontal, 12)
                .padding(.vertical, 4)
                .background(Color.green)
                .cornerRadius(20)
            
            Text(title)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
            
            Spacer()
            
            Image(systemName: imageName)
                .font(.system(size: 40))
                .foregroundColor(imageColor)
                .frame(maxWidth: .infinity, alignment: .trailing)
        }
        .frame(width: 160, height: 160)
        .padding(16)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5)
    }
}

struct MyPaymentsSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Мои платежи")
                    .font(.system(size: 24, weight: .bold))
                
                Spacer()
                
                Button(action: {}) {
                    HStack(spacing: 4) {
                        Text("Все")
                            .font(.system(size: 16))
                        Image(systemName: "chevron.right")
                            .font(.system(size: 14))
                    }
                    .foregroundColor(.primary)
                }
            }
            .padding(.horizontal)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    SavedPaymentCard(
                        icon: "iphone",
                        title: "Мой\nномер",
                        backgroundColor: .blue.opacity(0.1),
                        iconColor: .blue
                    )
                    
                    SavedPaymentCard(
                        icon: "antenna.radiowaves.left.and.right",
                        title: "Azercell",
                        subtitle: "102533806",
                        backgroundColor: .purple,
                        iconColor: .white,
                        isIconWhite: true
                    )
                    
                    SavedPaymentCard(
                        icon: "antenna.radiowaves.left.and.right",
                        title: "Azercell",
                        subtitle: "505199991",
                        backgroundColor: .purple,
                        iconColor: .white,
                        isIconWhite: true
                    )
                }
                .padding(.horizontal)
            }
        }
    }
}

struct SavedPaymentCard: View {
    let icon: String
    let title: String
    var subtitle: String? = nil
    let backgroundColor: Color
    let iconColor: Color
    var isIconWhite: Bool = false
    
    var body: some View {
        VStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 28))
                .foregroundColor(iconColor)
                .frame(width: 64, height: 64)
                .background(isIconWhite ? backgroundColor : backgroundColor)
                .cornerRadius(16)
            
            VStack(spacing: 2) {
                Text(title)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                
                if let subtitle = subtitle {
                    Text(subtitle)
                        .font(.system(size: 12))
                        .foregroundColor(.gray)
                }
            }
        }
        .frame(width: 110, height: 140)
        .background(Color.white)
        .cornerRadius(16)
        .shadow(color: Color.black.opacity(0.05), radius: 5)
    }
}

struct ServiceCategoriesSection: View {
    @Binding var selectedCategory: PaymentCategory?
    
    let categories = [
        PaymentCategory(
            id: "mobile",
            title: "Мобильные операторы",
            icon: "antenna.radiowaves.left.and.right",
            color: .cyan,
            hasCashback: true
        ),
        PaymentCategory(
            id: "utilities",
            title: "Коммунальные услуги",
            icon: "house.fill",
            color: .cyan,
            hasCashback: true
        ),
        PaymentCategory(
            id: "bakikart",
            title: "BakiKart",
            icon: "creditcard.fill",
            color: .cyan,
            hasCashback: false
        ),
        PaymentCategory(
            id: "banking",
            title: "Банковские услуги",
            icon: "building.columns.fill",
            color: .cyan,
            hasCashback: false,
            hasPromo: true
        )
    ]
    
    var body: some View {
        VStack(spacing: 12) {
            ForEach(categories) { category in
                CategoryRow(category: category) {
                    selectedCategory = category
                }
            }
        }
        .padding(.horizontal)
    }
}

struct CategoryRow: View {
    let category: PaymentCategory
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: category.icon)
                    .font(.system(size: 30))
                    .foregroundColor(category.color)
                    .frame(width: 48, height: 48)
                
                Text(category.title)
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(.primary)
                
                Spacer()
                
                if category.hasCashback {
                    HStack(spacing: 4) {
                        Image(systemName: "drop.fill")
                            .font(.system(size: 12))
                        Text("2%")
                            .font(.system(size: 12, weight: .bold))
                    }
                    .foregroundColor(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.blue)
                    .cornerRadius(12)
                }
                
                if category.hasPromo {
                    Text("🍋")
                        .font(.system(size: 24))
                        .frame(width: 48, height: 48)
                        .background(category.color)
                        .clipShape(Circle())
                }
            }
            .padding(16)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(color: Color.black.opacity(0.05), radius: 5)
        }
    }
}

struct PaymentCategory: Identifiable {
    let id: String
    let title: String
    let icon: String
    let color: Color
    var hasCashback: Bool = false
    var hasPromo: Bool = false
}

struct CategoryDetailView: View {
    let category: PaymentCategory
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: category.icon)
                    .font(.system(size: 80))
                    .foregroundColor(category.color)
                    .padding(40)
                
                Text(category.title)
                    .font(.title)
                    .bold()
                
                Text("Выберите провайдера для оплаты")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.top, 8)
                
                Spacer()
            }
            .navigationTitle(category.title)
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

struct PaymentsView_Previews: PreviewProvider {
    static var previews: some View {
        PaymentsView()
    }
}
