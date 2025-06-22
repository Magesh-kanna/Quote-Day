import Foundation

class QuoteViewModel: ObservableObject {
    @Published var currentQuote: Quote?
    @Published var favorites: [Quote] = []
    
    init() {
        loadFavorites()
    }
    
    func loadQuote() async {
        do {
            let quote = try await QuoteService.shared.fetchRandomQuote()
            await MainActor.run {
                self.currentQuote = quote
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    func addToFavorites() {
        guard let quote = currentQuote else { return }
        if !favorites.contains(where: { $0.q == quote.q && $0.a == quote.a }) {
            favorites.append(quote)
            saveFavorites()
        }
    }
    
    func removeFromFavorites(at index: Int) {
        favorites.remove(at: index)
        saveFavorites()
    }
    
    private func saveFavorites() {
        if let data = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(data, forKey: "favorites")
        }
    }
    
    private func loadFavorites() {
        if let data = UserDefaults.standard.data(forKey: "favorites"),
           let decoded = try? JSONDecoder().decode([Quote].self, from: data) {
            favorites = decoded
        }
    }
}
