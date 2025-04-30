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
                       Text("Sort by Change (\(viewModel.sortAscending ? "Ascending" : "Descending"))")
                           .font(.subheadline)
                           .padding()
                           .background(Color.blue.opacity(0.1))
                           .cornerRadius(8)
                   }
                   .padding(.top)
                   
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
                   .animation(.default, value: viewModel.favoriteStocks)
               }
               .navigationTitle("Favorites")
           }
       }
}



#Preview {
    let mockViewModel = StockViewModel()
    mockViewModel.favoriteStocks = [
        Stock(name: "Apple", ticker: "APPL", price: 240.18, price_change_24hrs: 1.43, is_featured: true),
        Stock(name: "Tesla", ticker: "TSLA", price: 281.95, price_change_24hrs: -8.85, is_featured: true)
    ]
    return FavoriteListView(viewModel: mockViewModel)
}
