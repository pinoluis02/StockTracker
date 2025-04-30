//
//  StockViewModel.swift
//  StockTracker
//
//  Created by Luis Perez on 4/28/25.
//

import Foundation
import SwiftUI

@MainActor
class StockViewModel: ObservableObject {
    @Published var allStocks: [Stock] = []
    @Published var favoriteStocks: [Stock] = []
    @Published var sortAscending: Bool = true
    @Published var lastUpdated: Date? = nil

    private let stockService: StockServiceProtocol
    private let userDefaults: UserDefaults
    private let persistenceKey = "favoriteStocks"
    
    private var pollingTask: Task<Void, Never>?
    
    init(stockService: StockServiceProtocol = StockService(), userDefaults: UserDefaults = .standard) {
        self.stockService = stockService
        self.userDefaults = userDefaults
        
        Task {
            await fetchStocks()
        }
        loadFavorites()
    }
    
    // Asynchronously fetch stocks and update published properties on the main actor
    func fetchStocks() async {
        do {
            let stocks = try await stockService.fetchStocks()
            self.allStocks = stocks
            self.lastUpdated = Date()
        } catch {
            print("Failed to fetch stocks: \(error.localizedDescription)")
        }
    }
    
    // Polling logic: start fetching stocks every 'interval' seconds
    func startPolling(interval: TimeInterval = 30.0) {
        pollingTask?.cancel()
        
        pollingTask = Task {
            while !Task.isCancelled {
                await fetchStocks()
                try? await Task.sleep(nanoseconds: UInt64(interval * 1_000_000_000))
            }
        }
    }
    
    func stopPolling() {
        pollingTask?.cancel()
        pollingTask = nil
    }
    
    deinit {
        let task = pollingTask
        Task.detached {
            task?.cancel()
        }
    }
    
    // Example functions for toggling favorites and persisting data
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
            self.userDefaults.set(data, forKey: persistenceKey)
        }
    }
    
    private func loadFavorites() {
        if let data = self.userDefaults.data(forKey: persistenceKey),
           let decoded = try? JSONDecoder().decode([Stock].self, from: data) {
            favoriteStocks = decoded
        }
    }
}

#if DEBUG
extension StockViewModel {
    static func mockStockViewModel() -> StockViewModel {
        let vm = StockViewModel()
        vm.allStocks = [
            Stock(name: "Apple", ticker: "APPL", price: 240.18, price_change_24hrs: 1.43, is_featured: true),
            Stock(name: "Tesla", ticker: "TSLA", price: 281.95, price_change_24hrs: -8.85, is_featured: true),
            Stock(name: "Amazon", ticker: "AMZN", price: 208.74, price_change_24hrs: 7.61, is_featured: false),
            Stock(name: "Nvidia", ticker: "NVDA", price: 120.15, price_change_24hrs: 11.13, is_featured: false)
        ]
        vm.favoriteStocks = [vm.allStocks[0], vm.allStocks[1]]
        return vm
    }
}
#endif
