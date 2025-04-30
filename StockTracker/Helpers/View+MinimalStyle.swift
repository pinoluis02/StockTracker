//
//  View+MinimalStyle.swift
//  StockTracker
//
//  Created by Luis Perez on 4/30/25.
//


import SwiftUI


extension View {
    
    /// Applies a card-like style with minimal background, corner radius, and soft shadow
    func minimalCardStyle(cornerRadius: CGFloat = 12) -> some View {
        self
            .padding()
            .background(Color(.secondarySystemBackground))
            .cornerRadius(cornerRadius)
            .shadow(color: Color.black.opacity(0.05), radius: 3, x: 0, y: 1)
    }
    
    /// Row styling: consistent vertical padding & clear list background
    func minimalRowStyle() -> some View {
        self
            .padding(.vertical, 6)
            .padding(.horizontal)
            .background(Color(.secondarySystemBackground))
            .cornerRadius(10)
            .listRowBackground(Color.clear)
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
    
    /// A clean capsule-style button modifier
    func minimalSortButtonStyle() -> some View {
        self
            .font(.subheadline)
            .foregroundColor(.accentColor)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Color(.systemGray6))
            .cornerRadius(12)
    }
}

extension View {
    /// Styles an empty state
    func minimalEmptyStateStyle() -> some View {
        self
            .multilineTextAlignment(.center)
            .foregroundColor(.secondary)
            .padding()
    }
}
