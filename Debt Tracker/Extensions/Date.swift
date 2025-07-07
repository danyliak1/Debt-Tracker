//
//  Date.swift
//  Debt Tracker
//
//  Created by Vladyslav Danyliak on 17.06.2025.
//

import Foundation

extension Formatter {
    static let fullDate: DateFormatter = {
        let formatter = DateFormatter()

        formatter.locale = Locale(identifier: "uk")

        formatter.dateFormat = "E, d MMMM yyyy"
        return formatter
    }()
}
