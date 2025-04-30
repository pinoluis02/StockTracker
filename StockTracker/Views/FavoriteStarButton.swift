//
//  FavoriteStarButton.swift
//  StockTracker
//
//  Created by Luis Perez on 4/30/25.
//

import SwiftUI

struct FavoriteStarButton: View {
    let isFavorite: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: {
            withAnimation {
                action()
            }
        }) {
            Image(systemName: isFavorite ? "star.fill" : "star")
                .foregroundColor(Color.favoriteIconColor(isFavorite: isFavorite))
                .scaleEffect(isFavorite ? 1.1 : 1.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.6), value: isFavorite)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

