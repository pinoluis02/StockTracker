//
//  StockListView.swift
//  StockTracker
//
//  Created by Luis Perez on 4/28/25.
//

import SwiftUI


struct StockListView: View {
    @ObservedObject var viewModel: StockViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                // Horizontal Featured Stocks
                if !viewModel.allStocks.filter({ $0.is_featured }).isEmpty {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            ForEach(viewModel.allStocks.filter { $0.is_featured }) { stock in
                                FeaturedStockCard(
                                    stock: stock,
                                    isFavorite: viewModel.isFavorite(stock: stock),
                                    favoriteAction: {
                                        withAnimation {
                                            viewModel.toggleFavorite(for: stock)
                                        }
                                    }
                                )
                            }
                        }
                        .padding([.horizontal, .top])
                    }
                }
                
                
                // Vertical All Stocks
                List {
                    ForEach(viewModel.allStocks) { stock in
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
                        .transition(.slide.combined(with: .opacity))
                    }
                }
                .listStyle(PlainListStyle())
                .minimalListBackground()
                .animation(.default, value: viewModel.favoriteStocks)
                .refreshable {
                    await viewModel.fetchStocks()
                }
            }
            .navigationTitle("Stocks")
        }
    }
}


#Preview("Light Mode") {
    StockListView(viewModel: .mockStockViewModel())
        .preferredColorScheme(.light)
}

#Preview("Dark Mode") {
    StockListView(viewModel: .mockStockViewModel())
        .preferredColorScheme(.dark)
}
