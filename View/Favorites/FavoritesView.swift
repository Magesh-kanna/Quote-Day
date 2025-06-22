//
//  FavoritesView.swift
//  Quote Day
//
//  Created by Magesh K on 22/06/25.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject var viewModel: QuoteViewModel
    
    var body: some View {
        List {
            ForEach(Array(viewModel.favorites.enumerated()), id: \.element.id) { index, quote in
                VStack(alignment: .leading, spacing: 4) {
                    Text("“\(quote.q)”")
                        .font(.body)
                    Text("- \(quote.a)")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 4)
                .swipeActions {
                    Button(role: .destructive) {
                        viewModel.removeFromFavorites(at: index)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
        }
        .navigationTitle("Favorites")
    }
}
