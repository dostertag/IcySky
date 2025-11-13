import SwiftUI

@main
struct GitHubBrowserApp: App {
    @State var gitHubService = GitHubService()
    @State var favoritesService = FavoritesService()

    var body: some Scene {
        WindowGroup {
            UserSearchView()
                .environment(gitHubService)
                .environment(favoritesService)
        }
    }
}
