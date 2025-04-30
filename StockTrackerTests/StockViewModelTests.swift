//
//  StockViewModelTests.swift
//  StockTrackerTests
//
//  Created by Luis Perez on 4/30/25.
//

import XCTest
@testable import StockTracker

final class StockViewModelTests: XCTestCase {
    
    func testViewModelLoadsMockStocks() async {
        let mockStocks = [
            Stock(name: "Mock Apple", ticker: "AAPL", price: 123.45, price_change_24hrs: 1.0, is_featured: true),
            Stock(name: "Mock Tesla", ticker: "TSLA", price: 789.00, price_change_24hrs: -2.3, is_featured: false)
        ]

        let mockService = MockStockService(mockStocks: mockStocks)
        let viewModel = StockViewModel(stockService: mockService)

        // Allow async fetch to complete
        try? await Task.sleep(nanoseconds: 100_000_000) // 0.1s

        XCTAssertEqual(viewModel.allStocks.count, 2)
        XCTAssertEqual(viewModel.allStocks.first?.name, "Mock Apple")
    }
    
    func testViewModelHandlesBadJSONGracefully() async {
        let badService = BadJSONStockService()
        let viewModel = StockViewModel(stockService: badService)

        // Wait briefly for async fetch
        try? await Task.sleep(nanoseconds: 100_000_000) // 0.1s

        // Ensure it failed silently and list is empty
        XCTAssertTrue(viewModel.allStocks.isEmpty, "allStocks should be empty after bad JSON")
    }

    
    func testToggleFavoriteUpdatesList() {
        
        let mockDefaults = UserDefaults(suiteName: "UnitTestDefaults")!
        // start clean
        mockDefaults.removePersistentDomain(forName: "UnitTestDefaults")
        
        let viewModel = StockViewModel(userDefaults: mockDefaults)
        let sample = Stock(name: "Apple", ticker: "APPL", price: 100, price_change_24hrs: 1, is_featured: false)
        viewModel.allStocks = [sample]
        
        // WHEN: Initially, stock is not favorited
        XCTAssertFalse(viewModel.isFavorite(stock: sample), "Stock should not be in favorites initially")

        // WHEN: Favoriting the stock
        viewModel.toggleFavorite(for: sample)
        
        // THEN: It should now be in favorites
        XCTAssertTrue(viewModel.isFavorite(stock: sample), "Stock should be favorited")

        // WHEN: Unfavoriting the stock
        viewModel.toggleFavorite(for: sample)
        
        // THEN: It should be removed from favorites
        XCTAssertFalse(viewModel.isFavorite(stock: sample), "Stock should be removed from favorites")
    }
}

