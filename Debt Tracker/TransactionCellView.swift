//
//  TransactionCellView.swift
//  Debt Tracker
//
//  Created by Vladyslav Danyliak on 16.06.2025.
//

import SwiftUI

struct TransactionCellView: View {
    
    let transaction: Transaction
    
    var body: some View {
        HStack {
            Text(transaction.formattedDate)
                .font(.system(size: 18, weight: .regular).monospaced())
                .foregroundStyle(.primary)
            Spacer()
            Text(transaction.formattedValue)
                .font(.system(size: 18, weight: .bold).monospaced())
                .foregroundStyle(transaction.isPositive ? .green : .red)
        }
        .contentShape(Rectangle())
        .padding(.vertical, 4)
        .padding(.horizontal, 12)
    }
}

#Preview {
    TransactionCellView(transaction: Transaction(value: 100, date: .now))
}
