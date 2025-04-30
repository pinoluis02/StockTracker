//
//  Stock.swift
//  StockTracker
//
//  Created by Luis Perez on 4/28/25.
//

import Foundation

struct Stock: Identifiable, Codable, Equatable {
    
    let id = UUID()
    let name: String
    let ticker: String
    let price: Double
    let price_change_24hrs: Double
    let is_featured: Bool
}

#if DEBUG
extension Stock {
    static var mockStock: Stock {
        Stock(
            name: "Apple",
            ticker: "APPL",
            price: 240.18,
            price_change_24hrs: 1.43,
            is_featured: true
        )
    }
}
#endif
