//
//  CustomError.swift
//  Debt Tracker
//
//  Created by Vladyslav Danyliak on 25.06.2025.
//

import Foundation

struct CustomError: LocalizedError {
    var code: ErrorType
    
    enum ErrorType: String, CaseIterable {
        case nilValue
        case other
    }
}
