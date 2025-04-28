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

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
