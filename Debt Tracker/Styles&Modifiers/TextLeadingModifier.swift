//
//  TextLeadingModifier.swift
//  Debt Tracker
//
//  Created by Vladyslav Danyliak on 16.06.2025.
//

import SwiftUI

struct TextLeadingModifier: ViewModifier {

    func body(content: Content) -> some View {
        content
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 16)
            .font(.title3.weight(.medium).monospaced())
    }
}

extension ViewModifier where Self == TextLeadingModifier {
    static var leadingText: TextLeadingModifier { .init() }
}
