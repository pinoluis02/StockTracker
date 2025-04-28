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
                Button(action: favoriteAction) {
                    Image(systemName: isFavorite ? "star.fill" : "star")
                        .foregroundColor(isFavorite ? .yellow : .gray)
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding()
        .frame(width: 160, height: 120)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(12)
        .shadow(radius: 4)
    }
}


//#Preview {
//    FeaturedStockCard()
//}
