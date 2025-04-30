//
//  StockServiceTests.swift
//  StockTrackerTests
//
//  Created by Luis Perez on 4/30/25.
//

import XCTest
@testable import StockTracker

final class StockServiceTests: XCTestCase {
    
    // MARK: - Integration Test (using real bundled JSON)
    
    func testFetchStocksParsesBundledJSONCorrectly() async throws {
        let service = StockService()
        let stocks = try await service.fetchStocks()
        
        XCTAssertFalse(stocks.isEmpty, "Expected non-empty stock list from bundled JSON")
        XCTAssertTrue(
            stocks.contains(where: { $0.ticker == "APPL" }),
            "Expected stock list to contain Apple (APPL)"
        )
    }
    
    // MARK: - Unit Test using Mock
    
    func test_mockStockService_returnsInjectedStocks() async throws {
        let mockStocks = [
            Stock(name: "Mock Apple", ticker: "APPL", price: 240.18, price_change_24hrs: 1.43, is_featured: true),
            Stock(name: "Mock Tesla", ticker: "TSLA", price: 281.95, price_change_24hrs: -8.85, is_featured: false)
        ]
        
        let mockService = MockStockService(mockStocks: mockStocks)
        let fetchedStocks = try await mockService.fetchStocks()
        
        XCTAssertEqual(fetchedStocks.count, 2, "Expected 2 mock stocks")
        XCTAssertEqual(fetchedStocks.first?.name, "Mock Apple")
        XCTAssertEqual(fetchedStocks.last?.ticker, "TSLA")
    }
    
    func testFailingStockService() async {
        let service = BadJSONStockService()
        
        do {
            _ = try await service.fetchStocks()
            XCTFail("Expected fetchStocks to throw due to bad JSON")
        } catch let decodingError as DecodingError {
            // Expected: Decoding failed
            switch decodingError {
            case .typeMismatch(let type, let context):
                XCTAssertTrue(type == Double.self, "Expected type mismatch on Double")
                XCTAssertTrue(context.debugDescription.contains("Expected to decode Double"))
            default:
                XCTFail("Expected typeMismatch decoding error, got: \(decodingError)")
            }
        } catch {
            XCTFail("Expected DecodingError, got: \(error)")
        }
    }
}


struct MockStockService: StockServiceProtocol {
    var mockStocks: [Stock]

    func fetchStocks() async throws -> [Stock] {
        return mockStocks
    }
}

struct BadJSONStockService: StockServiceProtocol {
    func fetchStocks() async throws -> [Stock] {
        let badJSONString = """
        [
            { "name": "Apple", "ticker": "AAPL", "price": "not-a-number" }
        ]
        """.data(using: .utf8)!
        
        return try JSONDecoder().decode([Stock].self, from: badJSONString)
    }
}
