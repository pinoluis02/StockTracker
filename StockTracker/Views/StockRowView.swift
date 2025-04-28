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
        HStack {
            VStack(alignment: .leading) {
                Text(stock.name)
                    .font(.headline)
                Text(stock.ticker)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            Spacer()
            VStack(alignment: .trailing) {
                Text("$\(stock.price, specifier: "%.2f")")
                    .font(.headline)
                Text("\(stock.price_change_24hrs >= 0 ? "+" : "")\(stock.price_change_24hrs, specifier: "%.2f")%")
                    .font(.subheadline)
                    .foregroundColor(stock.price_change_24hrs >= 0 ? .green : .red)
            }
            Button(action: favoriteAction) {
                Image(systemName: isFavorite ? "star.fill" : "star")
                    .foregroundColor(isFavorite ? .yellow : .gray)
            }
            .buttonStyle(PlainButtonStyle())
        }
        .padding(.vertical, 8)
    }
}


//#Preview {
//    StockRowView()
//}
