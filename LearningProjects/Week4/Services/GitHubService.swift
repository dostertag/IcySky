import Foundation
import Observation

@Observable
final class GitHubService {
    enum ServiceError: LocalizedError {
        case invalidURL
        case invalidResponse
        case userNotFound

        var errorDescription: String? {
            switch self {
            case .invalidURL: return "Invalid URL"
            case .invalidResponse: return "Invalid response from server"
            case .userNotFound: return "User not found"
            }
        }
    }

    func fetchUser(username: String) async throws -> GitHubUser {
        guard let url = URL(string: "https://api.github.com/users/\(username)") else {
            throw ServiceError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw ServiceError.invalidResponse
        }

        if httpResponse.statusCode == 404 {
            throw ServiceError.userNotFound
        }

        guard httpResponse.statusCode == 200 else {
            throw ServiceError.invalidResponse
        }

        let decoder = JSONDecoder()
        let user = try decoder.decode(GitHubUser.self, from: data)
        return user
    }

    func fetchRepositories(for username: String) async throws -> [Repository] {
        guard let url = URL(string: "https://api.github.com/users/\(username)/repos") else {
            throw ServiceError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw ServiceError.invalidResponse
        }

        let decoder = JSONDecoder()
        let repos = try decoder.decode([Repository].self, from: data)
        return repos.sorted { $0.stargazersCount > $1.stargazersCount }
    }
}
