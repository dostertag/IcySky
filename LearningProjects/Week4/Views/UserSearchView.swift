import SwiftUI

struct UserSearchView: View {
    @Environment(GitHubService.self) var service
    @Environment(FavoritesService.self) var favoritesService // Inject FavoritesService
    @State private var username: String = ""
    @State private var viewState: ViewState = .initial

    enum ViewState {
        case initial
        case loading
        case loaded(GitHubUser, [Repository])
        case error(String)
    }

    var body: some View {
        NavigationStack {
            VStack {
                searchBar

                switch viewState {
                case .initial:
                    ContentUnavailableView(
                        "Search GitHub Users",
                        systemImage: "magnifyingglass",
                        description: Text("Enter a username to get started")
                    )

                case .loading:
                    ProgressView("Fetching data...")

                case .loaded(let user, let repos):
                    ScrollView {
                        userProfileView(user)
                        repositoriesSection(repos)
                    }

                case .error(let message):
                    ContentUnavailableView(
                        "Error",
                        systemImage: "exclamationmark.triangle",
                        description: Text(message)
                    )
                }
            }
            .navigationTitle("GitHub Browser")
        }
    }

    private var searchBar: some View {
        HStack {
            TextField("GitHub username", text: $username)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()

            Button("Search") {
                searchUser()
            }
            .buttonStyle(.borderedProminent)
            .disabled(username.isEmpty)
        }
        .padding()
    }

    private func searchUser() {
        Task {
            viewState = .loading
            do {
                async let user = service.fetchUser(username: username)
                async let repos = service.fetchRepositories(for: username)

                let (fetchedUser, fetchedRepos) = try await (user, repos)
                viewState = .loaded(fetchedUser, fetchedRepos)
            } catch {
                viewState = .error(error.localizedDescription)
            }
        }
    }

    private func userProfileView(_ user: GitHubUser) -> some View {
        VStack(spacing: 12) {
            AsyncImage(url: URL(string: user.avatarUrl)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 120, height: 120)
            .clipShape(Circle())

            Text(user.name ?? user.login)
                .font(.title)
                .bold()

            if let bio = user.bio {
                Text(bio)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }

            Text("\(user.publicRepos) public repositories")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }

    private func repositoriesSection(_ repos: [Repository]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Repositories")
                .font(.headline)
                .padding(.horizontal)

            ForEach(repos) { repo in
                RepositoryRowView(repo: repo)
            }
        }
    }
}
