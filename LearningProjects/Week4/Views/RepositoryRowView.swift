import SwiftUI

struct RepositoryRowView: View {
    let repo: Repository
    @Environment(FavoritesService.self) var favoritesService

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(repo.name)
                    .font(.headline)
                if let description = repo.description {
                    Text(description)
                        .font(.subheadline)
                        .lineLimit(2)
                }
                HStack {
                    Image(systemName: "star.fill")
                        .font(.caption)
                    Text("\(repo.stargazersCount)")
                    Image(systemName: "tuningfork")
                        .font(.caption)
                    Text("\(repo.forksCount)")
                    if let language = repo.language {
                        Text(language)
                            .font(.caption)
                            .padding(.horizontal, 4)
                            .background(Capsule().fill(Color.blue.opacity(0.2)))
                    }
                }
                .font(.caption)
                .foregroundStyle(.secondary)
            }
            Spacer()
            Button {
                favoritesService.toggleFavorite(repo)
            } label: {
                Image(systemName: favoritesService.isFavorite(repo) ? "heart.fill" : "heart")
                    .foregroundColor(favoritesService.isFavorite(repo) ? .red : .gray)
            }
            .buttonStyle(.plain)
        }
        .padding(.vertical, 4)
        .padding(.horizontal)
    }
}
