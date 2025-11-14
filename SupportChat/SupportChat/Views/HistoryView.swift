//
//  HistoryView.swift
//  SupportChat
//
//  Created on 11/14/2025.
//

import SwiftUI

struct HistoryView: View {
    @State private var selectedFilter: TransactionFilter = .all
    @State private var transactions: [Transaction] = []
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Filter chips
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach(TransactionFilter.allCases, id: \.self) { filter in
                            FilterChip(
                                title: filter.title,
                                isSelected: selectedFilter == filter
                            ) {
                                selectedFilter = filter
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.vertical, 12)
                }
                
                // Content
                if transactions.isEmpty {
                    EmptyHistoryView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                } else {
                    TransactionsList(transactions: filteredTransactions)
                }
            }
            .background(Color.gray.opacity(0.05))
            .navigationTitle("Операции")
            .navigationBarTitleDisplayMode(.large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {}) {
                        Image(systemName: "line.3.horizontal.decrease.circle")
                            .font(.system(size: 20))
                    }
                }
            }
        }
        .onAppear {
            loadTransactions()
        }
    }
    
    private var filteredTransactions: [Transaction] {
        switch selectedFilter {
        case .all:
            return transactions
        case .incoming:
            return transactions.filter { $0.type == .incoming }
        case .outgoing:
            return transactions.filter { $0.type == .outgoing }
        case .payments:
            return transactions.filter { $0.type == .payment }
        }
    }
    
    private func loadTransactions() {
        // In a real app, this would load from API or database
        // For now, we'll show empty state
        transactions = []
    }
}

enum TransactionFilter: CaseIterable {
    case all
    case incoming
    case outgoing
    case payments
    
    var title: String {
        switch self {
        case .all:
            return "Все"
        case .incoming:
            return "Поступления"
        case .outgoing:
            return "Переводы"
        case .payments:
            return "Платежи"
        }
    }
}

struct FilterChip: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(isSelected ? .white : .primary)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(isSelected ? Color.cyan : Color.white)
                .cornerRadius(20)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(isSelected ? Color.clear : Color.gray.opacity(0.3), lineWidth: 1)
                )
        }
    }
}

struct EmptyHistoryView: View {
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                Circle()
                    .fill(Color.gray.opacity(0.1))
                    .frame(width: 100, height: 100)
                
                Image(systemName: "clock.arrow.circlepath")
                    .font(.system(size: 50))
                    .foregroundColor(.gray.opacity(0.3))
            }
            
            Text("Нет операций")
                .font(.system(size: 18, weight: .semibold))
            
            Text("История ваших транзакций появится здесь")
                .font(.system(size: 16))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
        }
    }
}

struct TransactionsList: View {
    let transactions: [Transaction]
    
    var transactionsByDate: [(date: Date, transactions: [Transaction])] {
        Dictionary(grouping: transactions) { $0.date.startOfDay }
            .map { (date: $0.key, transactions: $0.value) }
            .sorted { $0.date > $1.date }
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                ForEach(transactionsByDate, id: \.date) { group in
                    VStack(alignment: .leading, spacing: 12) {
                        Text(group.date.formatted(date: .long, time: .omitted))
                            .font(.system(size: 20, weight: .semibold))
                            .padding(.horizontal)
                        
                        ForEach(group.transactions) { transaction in
                            TransactionRow(transaction: transaction)
                                .padding(.horizontal)
                        }
                    }
                }
            }
            .padding(.vertical, 20)
        }
    }
}

struct TransactionRow: View {
    let transaction: Transaction
    
    var body: some View {
        HStack {
            // Icon
            Image(systemName: transaction.icon)
                .font(.system(size: 24))
                .foregroundColor(transaction.iconColor)
                .frame(width: 48, height: 48)
                .background(transaction.iconColor.opacity(0.1))
                .clipShape(Circle())
            
            // Info
            VStack(alignment: .leading, spacing: 4) {
                Text(transaction.title)
                    .font(.system(size: 16, weight: .medium))
                
                Text(transaction.subtitle)
                    .font(.system(size: 14))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // Amount
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(transaction.type == .incoming ? "+" : "-")\(transaction.amount, specifier: "%.2f") ₼")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundColor(transaction.type == .incoming ? .green : .primary)
                
                Text(transaction.date.formatted(date: .omitted, time: .shortened))
                    .font(.system(size: 12))
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal, 16)
        .background(Color.white)
        .cornerRadius(16)
    }
}

// Transaction Model
struct Transaction: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let amount: Double
    let type: TransactionType
    let date: Date
    
    var icon: String {
        switch type {
        case .incoming:
            return "arrow.down.circle.fill"
        case .outgoing:
            return "arrow.up.circle.fill"
        case .payment:
            return "creditcard.fill"
        }
    }
    
    var iconColor: Color {
        switch type {
        case .incoming:
            return .green
        case .outgoing:
            return .blue
        case .payment:
            return .orange
        }
    }
}

enum TransactionType {
    case incoming
    case outgoing
    case payment
}

// Date extension for grouping
extension Date {
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
}

struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView()
    }
}
