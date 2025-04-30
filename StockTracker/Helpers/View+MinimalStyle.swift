//
//  View+MinimalStyle.swift
//  StockTracker
//
//  Created by Luis Perez on 4/30/25.
//


import SwiftUI


extension View {
    
    /// Applies a card-like style with minimal background, corner radius, and soft shadow
    func minimalCardStyle() -> some View {
        self
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(12)
            .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 1)
    }
    
    /// Applies lightweight padding and a plain, breathable feel
    func minimalRowPadding() -> some View {
        self
            .padding(.vertical, 6)
            .padding(.horizontal)
    }
    
    /// Hides background of List scroll area for cleaner cards
    func minimalListBackground() -> some View {
        self
            .scrollContentBackground(.hidden)
            .background(Color(.systemBackground))
    }
}
