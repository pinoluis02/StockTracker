//
//  StockService.swift
//  StockTracker
//
//  Created by Luis Perez on 4/28/25.
//

import Foundation


class StockService {
    static func fetchStocks() async throws -> [Stock] {
        
        try await Task.sleep(nanoseconds: 1_000_000_000) // 1 second delay
        guard let url = Bundle.main.url(forResource: "example_response", withExtension: "json"),
              let data = try? Data(contentsOf: url) else {
            throw URLError(.badServerResponse)
        }
        return try JSONDecoder().decode([Stock].self, from: data)
    }
}
