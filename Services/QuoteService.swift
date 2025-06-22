//
//  QuoteService.swift
//  Quote Day
//
//  Created by Magesh K on 22/06/25.
//

import Foundation

class QuoteService {
    static let shared = QuoteService()
    
    func fetchQuotes() async throws -> [Quote] {
        let url = URL(string: "https://zenquotes.io/api/quotes")!
        let (data, _) = try await URLSession.shared.data(from: url)
        return try JSONDecoder().decode([Quote].self, from: data)
    }
    
    func fetchRandomQuote() async throws -> Quote {
        let quotes = try await fetchQuotes()
        return quotes.randomElement() ?? Quote(q: "No Quote", a: "Unknown")
    }
}
