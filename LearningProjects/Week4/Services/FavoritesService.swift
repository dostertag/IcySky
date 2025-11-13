import Foundation
import Observation

@Observable
final class FavoritesService {
    private let favoritesKey = "favoriteRepos"
    private(set) var favorites: [Repository] = []

    init() {
        loadFavorites()
    }

    func toggleFavorite(_ repo: Repository) {
        if let index = favorites.firstIndex(where: { $0.id == repo.id }) {
            favorites.remove(at: index)
        } else {
            favorites.append(repo)
        }
        saveFavorites()
    }

    func isFavorite(_ repo: Repository) -> Bool {
        favorites.contains(where: { $0.id == repo.id })
    }

    private func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }

    private func loadFavorites() {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey),
              let decoded = try? JSONDecoder().decode([Repository].self, from: data) else {
            return
        }
        favorites = decoded
    }
}
