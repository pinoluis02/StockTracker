//
//  StockTrackerApp.swift
//  StockTracker
//
//  Created by Luis Perez on 4/28/25.
//

import SwiftUI

@main
struct StockTrackerApp: App {
    let persistenceController = PersistenceController.shared
    
    @AppStorage("preferredTheme") private var preferredThemeRaw: String = ThemeOption.system.rawValue

    init() {
        UITabBar.appearance().isTranslucent = true
        UITabBar.appearance().backgroundColor = UIColor.systemBackground
    }
    
    var body: some Scene {
        let selectedTheme = ThemeOption(rawValue: preferredThemeRaw) ?? .system

        WindowGroup {
            ContentView()
                .preferredColorScheme(selectedTheme.colorScheme)
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
