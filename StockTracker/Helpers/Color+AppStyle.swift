//
//  Color+AppStyle.swift
//  StockTracker
//
//  Created by Luis Perez on 4/30/25.
//

import SwiftUI

extension Color {
    
    static func favoriteIconColor(isFavorite: Bool) -> Color {
        isFavorite ? Color("SoftGold") : .gray.opacity(0.3)
    }
}

