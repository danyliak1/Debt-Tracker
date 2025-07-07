//
//  Transaction.swift
//  Debt Tracker
//
//  Created by Vladyslav Danyliak on 17.06.2025.
//

import Foundation
import Swift

struct Transaction: Identifiable, Equatable, Codable {
    var value: Int = 0
    var date: Date = .now
    var id: UUID = UUID()
    
    var formattedDate: String {
        "\(Formatter.fullDate.string(from: date).firstUppercased)"
    }
    var formattedValue: String {
        "\(abs(value))"
    }
    var isPositive: Bool {
        value > 0
    }
}

