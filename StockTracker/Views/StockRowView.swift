//
//  StockRowView.swift
//  StockTracker
//
//  Created by Luis Perez on 4/28/25.
//

import SwiftUI


struct StockRowView: View {
    
    let stock: Stock
    let isFavorite: Bool
    let favoriteAction: () -> Void
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 4) {
                Text(stock.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                Text(stock.ticker)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("$\(stock.price, specifier: "%.2f")")
                    .font(.headline)
                    .foregroundColor(.primary)
                Text("\(stock.price_change_24hrs >= 0 ? "+" : "")\(stock.price_change_24hrs, specifier: "%.2f")%")
                    .font(.subheadline)
                    .foregroundColor(stock.price_change_24hrs >= 0 ? .green : .red)
            }
            
            FavoriteStarButton(isFavorite: isFavorite, action: favoriteAction)
        }
        .minimalRowStyle()
    }
}


#Preview("Favorited - Light Mode") {
    StockRowView(
        stock: .mockStock,
        isFavorite: true,
        favoriteAction: {}
    )
    .preferredColorScheme(.light)
    .padding()
}

#Preview("Not Favorited - Dark Mode") {
    StockRowView(
        stock: .mockStock,
        isFavorite: false,
        favoriteAction: {}
    )
    .preferredColorScheme(.dark)
    .padding()
}

