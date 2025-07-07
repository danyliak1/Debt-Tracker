//
//  KeychainService.swift
//  Debt Tracker
//
//  Created by Vladyslav Danyliak on 18.06.2025.
//

import SwiftUI
import KeychainAccess

@propertyWrapper
struct KeychainStorage: DynamicProperty {

    let keychainManager = Keychain()
    let key: String
    var wrappedValue: String {
        didSet {
            keychainManager[key] = wrappedValue
        }
    }

    init(wrappedValue: String = "", _ key: String) {
        self.key = key
        let initialValue = (keychainManager[key] ?? wrappedValue)
        self.wrappedValue = initialValue
    }
}
