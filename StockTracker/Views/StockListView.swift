//
//  StockListView.swift
//  StockTracker
//
//  Created by Luis Perez on 4/28/25.
//

import SwiftUI


struct StockListView: View {
    @ObservedObject var viewModel: StockViewModel
    @AppStorage("enablePolling") private var enablePolling: Bool = true

    
    var body: some View {
        NavigationView {
            VStack {
                if let lastUpdated = viewModel.lastUpdated {
                    Text("Last updated: \(lastUpdated.formatted(.relative(presentation: .named)))")
                        .font(.caption)
                        .foregroundColor(.secondary)
                        .padding(.horizontal)
                        .padding(.top)
                }
                // Horizontal Featured Stocks
                if !viewModel.allStocks.filter({ $0.is_featured }).isEmpty {
                    
                    SectionLabel(text: "Featured", topPadding: 16)
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
                    .padding(.bottom, 12)
                }
                
                // Vertical All Stocks
                SectionLabel(text: "All Stocks", topPadding: 12)
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
                        .listRowSeparator(.hidden)
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
        .onAppear {
            if enablePolling {
                viewModel.startPolling()
            }
        }
        .onDisappear {
            viewModel.stopPolling()
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
