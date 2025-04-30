//
//  ContentView.swift
//  StockTracker
//
//  Created by Luis Perez on 4/28/25.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @StateObject private var viewModel = StockViewModel()
    
    var body: some View {
        TabView {
            StockListView(viewModel: viewModel)
                .tabItem {
                    Label("Stocks", systemImage: "list.bullet")
                }
            
            FavoriteListView(viewModel: viewModel)
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
            
            NavigationStack {
                SettingsView()
            }
            .tabItem {
                Label("Settings", systemImage: "gear")
            }
        }
    }
    
}

#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
