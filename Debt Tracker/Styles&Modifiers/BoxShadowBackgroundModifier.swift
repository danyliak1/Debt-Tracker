//
//  BoxShadowBackgroundModifier.swift
//  Debt Tracker
//
//  Created by Vladyslav Danyliak on 01.07.2025.
//

import SwiftUI

struct BoxShadowBackgroundModifier: ViewModifier {
    
    var color: Color = .white

    func body(content: Content) -> some View {
        content
            .background {
                Rectangle()
                    .fill(color)
                    .strokeBorder(style: .init(lineWidth: 3))
                    .background {
                        Rectangle()
                            .foregroundStyle(.primary)
                            .offset(x: 4, y: 2.5)
                    }
            }
    }
}

extension ViewModifier where Self == BoxShadowBackgroundModifier {
    static var boxPrimaryShadow: BoxShadowBackgroundModifier { .init() }
    static var boxSecondaryShadow: BoxShadowBackgroundModifier { .init(color: .black) }
}
