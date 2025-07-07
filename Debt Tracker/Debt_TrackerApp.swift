//
//  Debt_TrackerApp.swift
//  Debt Tracker
//
//  Created by Vladyslav Danyliak on 16.06.2025.
//

import SwiftUI

@main
struct Debt_TrackerApp: App {
    @StateObject private var vm = ViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(vm)
        }
    }
}
