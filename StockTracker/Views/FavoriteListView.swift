//
//  FavoriteListView.swift
//  StockTracker
//
//  Created by Luis Perez on 4/28/25.
//

import SwiftUI

struct FavoriteListView: View {
    @ObservedObject var viewModel: StockViewModel
       
       var body: some View {
           NavigationView {
               VStack {
                   // Sort Button
                   Button(action: {
                       viewModel.toggleSortOrder()
                   }) {
                       Label(
                        viewModel.sortAscending ? "Ascending" : "Descending",
                        systemImage: viewModel.sortAscending ? "arrow.up" : "arrow.down"
                       )
                   }
                   .minimalSortButtonStyle()
                   
                   // Favorite Stocks List
                   List {
                       ForEach(viewModel.sortedFavorites()) { stock in
                           StockRowView(stock: stock, isFavorite: viewModel.isFavorite(stock: stock)) {
                               withAnimation {
                                   viewModel.toggleFavorite(for: stock)
                               }
                           }
                           .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                               Button(role: .destructive) {
                                   withAnimation {
                                       viewModel.toggleFavorite(for: stock)
                                   }
                               } label: {
                                   Label("Unfavorite", systemImage: "star.slash")
                               }
                           }
                           .transition(.slide.combined(with: .opacity))
                       }
                   }
                   .listStyle(PlainListStyle())
                   .minimalListBackground()
                   .animation(.default, value: viewModel.favoriteStocks)
               }
               .navigationTitle("Favorites")
           }
       }
}



#Preview("Light Mode") {
    FavoriteListView(viewModel: .mockStockViewModel())
        .preferredColorScheme(.light)
}


#Preview("Dark Mode") {
    FavoriteListView(viewModel: .mockStockViewModel())
        .preferredColorScheme(.dark)
}
