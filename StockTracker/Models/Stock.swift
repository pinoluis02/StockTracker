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
