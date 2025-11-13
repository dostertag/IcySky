import Foundation

struct Weather: Identifiable {
    let id = UUID()
    let city: String
    let temperature: Int
    let condition: String
    let humidity: Int
}
