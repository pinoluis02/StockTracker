//
//  SectionLabel.swift
//  StockTracker
//
//  Created by Luis Perez on 4/30/25.
//

import SwiftUI

struct SectionLabel: View {
    let text: String
    var topPadding: CGFloat = 0
    var bottomPadding: CGFloat = 0

    var body: some View {
        Text(text.uppercased())
            .font(.caption)
            .fontWeight(.medium)
            .foregroundColor(.secondary)
            .padding(.top, topPadding)
            .padding(.horizontal)
            .padding(.bottom, bottomPadding)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}


#Preview("SectionLabel", traits: .sizeThatFitsLayout) {
    SectionLabel(text: "All Stocks")
        .padding()
}
