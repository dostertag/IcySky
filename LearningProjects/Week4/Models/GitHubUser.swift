import Foundation

struct GitHubUser: Codable, Identifiable {
    let id: Int
    let login: String
    let name: String?
    let bio: String?
    let avatarUrl: String
    let publicRepos: Int

    enum CodingKeys: String, CodingKey {
        case id, login, name, bio
        case avatarUrl = "avatar_url"
        case publicRepos = "public_repos"
    }
}
