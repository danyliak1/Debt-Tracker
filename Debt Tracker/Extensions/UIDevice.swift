//
//  UIDevice.swift
//  Debt Tracker
//
//  Created by Vladyslav Danyliak on 02.07.2025.
//

import UIKit

extension UIDevice {
    static var keyWindow: UIWindow? {
        UIApplication.shared.connectedScenes
            .filter { $0.activationState == .foregroundActive }
            .first { $0 is UIWindowScene }
            .flatMap { $0 as? UIWindowScene }?.windows
            .first(where: \.isKeyWindow)
    }
}
