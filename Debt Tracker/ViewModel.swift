//
//  ViewModel.swift
//  Debt Tracker
//
//  Created by Vladyslav Danyliak on 17.06.2025.
//

import SwiftUI

final class ViewModel: ObservableObject {
    @Published private(set) var transactions: [Transaction] = []
    
    @KeychainStorage("leftover") private(set) var leftover: String = "0"
    @KeychainStorage("totalDebt") private(set) var totalDebt: String = "0"
    @KeychainStorage("transactions") private(set) var savedTransactions: String = "[]"
        
    func loadTransactions() throws {
        guard let savedTransactionsData = savedTransactions.data(using: .utf8) else {
            throw CustomError(code: .nilValue)
        }
        transactions = try JSONDecoder().decode([Transaction].self, from: savedTransactionsData)
    }
    
    private func saveTransactions() throws {
        let transactionData = try JSONEncoder().encode(transactions)
        if let savedTransactionsData = String(data: transactionData, encoding: .utf8) {
            savedTransactions = savedTransactionsData
        }
    }
    
    func add(value: String, date: Date) throws {
        guard let value = value.int,
              var leftoverValue = leftover.int,
              var debtValue = totalDebt.int else {
            throw CustomError(code: .nilValue)
        }
        transactions.insert(Transaction(value: value, date: date), at: 0)
        transactions.sort { $0.date > $1.date }
        
        leftoverValue = max(leftoverValue + value, 0)
        
        if value < 0 {
            debtValue -= abs(value)
        }
        
        leftover = String(leftoverValue)
        totalDebt = String(debtValue)
        
        try saveTransactions()
    }
    
    func remove(transaction: Transaction) throws {
        guard var leftoverValue = leftover.int,
              var debtValue = totalDebt.int,
              transactions.contains(transaction) else {
            throw CustomError(code: .nilValue)
        }
        
        transactions.removeAll { $0 == transaction }
        
        leftoverValue = max(leftoverValue + transaction.value * -1, 0)
        
        if transaction.value < 0 {
            debtValue += abs(transaction.value)
        }
        
        leftover = leftoverValue.string
        totalDebt = debtValue.string
        
        try saveTransactions()
    }
}
