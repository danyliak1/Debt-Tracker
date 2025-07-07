//
//  String.swift
//  Debt Tracker
//
//  Created by Vladyslav Danyliak on 17.06.2025.
//

import Foundation

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var int: Int? { Int(self) }
}
