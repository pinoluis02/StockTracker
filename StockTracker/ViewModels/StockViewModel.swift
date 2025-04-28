//
//  StockViewModel.swift
//  StockTracker
//
//  Created by Luis Perez on 4/28/25.
//

import Foundation
import SwiftUI


class StockViewModel: ObservableObject {
    @Published var allStocks: [Stock] = []
    @Published var favoriteStocks: [Stock] = []
    @Published var sortAscending: Bool = true

    private let persistenceKey = "favoriteStocks"
    
    init() {
        Task {
            await fetchStocks()
        }
        loadFavorites()
    }
    
    func fetchStocks() async {
        do {
            let stocks = try await StockService.fetchStocks()
            DispatchQueue.main.async {
                self.allStocks = stocks
            }
        } catch {
            print("Failed to fetch stocks: \(error.localizedDescription)")
        }
    }
    
    func toggleFavorite(for stock: Stock) {
        if favoriteStocks.contains(where: { $0.ticker == stock.ticker }) {
            favoriteStocks.removeAll { $0.ticker == stock.ticker }
        } else {
            favoriteStocks.append(stock)
        }
        saveFavorites()
    }
    
    func isFavorite(stock: Stock) -> Bool {
        favoriteStocks.contains(where: { $0.ticker == stock.ticker })
    }
    
    func sortedFavorites() -> [Stock] {
        favoriteStocks.sorted {
            sortAscending ? $0.price_change_24hrs < $1.price_change_24hrs :
                            $0.price_change_24hrs > $1.price_change_24hrs
        }
    }
    
    func toggleSortOrder() {
        sortAscending.toggle()
    }
    
    private func saveFavorites() {
        if let data = try? JSONEncoder().encode(favoriteStocks) {
            UserDefaults.standard.set(data, forKey: persistenceKey)
        }
    }
    
    private func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: persistenceKey),
           let decoded = try? JSONDecoder().decode([Stock].self, from: data) {
            favoriteStocks = decoded
        }
    }
}
