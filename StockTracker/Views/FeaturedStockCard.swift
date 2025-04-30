//
//  FeaturedStockCard.swift
//  StockTracker
//
//  Created by Luis Perez on 4/28/25.
//

import SwiftUI


struct FeaturedStockCard: View {
    let stock: Stock
    let isFavorite: Bool
    let favoriteAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(stock.name)
                .font(.headline)
            Text(stock.ticker)
                .font(.subheadline)
                .foregroundColor(.gray)
            Spacer()
            HStack {
                Text("$\(stock.price, specifier: "%.2f")")
                    .bold()
                Spacer()
                FavoriteStarButton(isFavorite: isFavorite, action: favoriteAction)
                    .accessibilityIdentifier("star-\(stock.ticker)")
            }
        }
        .minimalCardStyle()
        .frame(width: 160, height: 120)
    }
}


#Preview("Light Mode") {
    FeaturedStockCard(
        stock: .mockStock,
        isFavorite: true,
        favoriteAction: {}
    )
    .preferredColorScheme(.light)
    .padding()
}

#Preview("Dark Mode") {
    FeaturedStockCard(
        stock: .mockStock,
        isFavorite: true,
        favoriteAction: {}
    )
    .preferredColorScheme(.dark)
    .padding()
}
