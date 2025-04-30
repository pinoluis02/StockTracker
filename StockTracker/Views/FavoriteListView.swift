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
                if !viewModel.favoriteStocks.isEmpty {
                    HStack {
                        Spacer()
                        Button(action: {
                            viewModel.toggleSortOrder()
                        }) {
                            Label(
                                viewModel.sortAscending ? "Ascending" : "Descending",
                                systemImage: viewModel.sortAscending ? "arrow.up" : "arrow.down"
                            )
                        }
                        .minimalSortButtonStyle()
                        .padding(.trailing, 24)
                    }
                    .padding(.top, 4)
                }
                
                // Empty State
                if viewModel.favoriteStocks.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "star")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.gray)
                        
                        Text("No favorites yet")
                            .font(.headline)
                        
                        Text("Tap the star on a stock to add it here")
                            .font(.subheadline)
                    }
                    .minimalEmptyStateStyle()
                    .transition(.opacity)
                } else {
                    // Favorite Stocks List
                    List {
                        ForEach(viewModel.sortedFavorites()) { stock in
                            StockRowView(
                                stock: stock,
                                isFavorite: viewModel.isFavorite(stock: stock),
                                favoriteAction: {
                                    withAnimation {
                                        viewModel.toggleFavorite(for: stock)
                                    }
                                }
                            )
                            .minimalRowStyle()
                            .listRowSeparator(.hidden)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    withAnimation {
                                        viewModel.toggleFavorite(for: stock)
                                    }
                                } label: {
                                    Label("Unfavorite", systemImage: "star.slash")
                                }
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    .minimalListBackground()
                    .animation(.default, value: viewModel.favoriteStocks)
                }
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

#Preview("Empty State") {
    FavoriteListView(viewModel: StockViewModel())
}
