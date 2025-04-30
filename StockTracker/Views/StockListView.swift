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
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.allStocks.filter { $0.is_featured }) { stock in
                            FeaturedStockCard(stock: stock, isFavorite: viewModel.isFavorite(stock: stock)) {
                                viewModel.toggleFavorite(for: stock)
                            }
                        }
                    }
                    .padding()
                }
                
                // Vertical All Stocks
                List {
                    ForEach(viewModel.allStocks) { stock in
                        StockRowView(stock: stock, isFavorite: viewModel.isFavorite(stock: stock)) {
                            viewModel.toggleFavorite(for: stock)
                        }
                    }
                }
                .listStyle(PlainListStyle())
                .minimalListBackground()
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
