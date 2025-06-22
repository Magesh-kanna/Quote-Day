//
//  ContentView.swift
//  Quote Day
//
//  Created by Magesh K on 22/06/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = QuoteViewModel()
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                if let quote = viewModel.currentQuote {
                    Text("“\(quote.q)”")
                        .font(.title2)
                        .italic()
                        .multilineTextAlignment(.center)
                        .padding()
                    
                    Text("- \(quote.a)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Button("Add to Favorites") {
                        viewModel.addToFavorites()
                    }
                    .buttonStyle(.borderedProminent)
                } else {
                    ProgressView("Loading Quote...")
                }
                
                Button("New Quote") {
                    Task {
                        await viewModel.loadQuote()
                    }
                }
            }
            .padding()
            .navigationTitle("Quote of the Day")
            .toolbar {
                NavigationLink("Favorites") {
                    FavoritesView(viewModel: viewModel)
                }
            }
            .onAppear {
                Task {
                    await viewModel.loadQuote()
                }
            }
        }
    }
}
