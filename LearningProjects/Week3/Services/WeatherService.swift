import Foundation
import Observation

@Observable
final class WeatherService {
    private(set) var currentWeather: Weather?
    private(set) var forecast: [ForecastDay] = []

    enum ServiceError: LocalizedError {
        case invalidURL
        case invalidResponse
        case userNotFound // This might be specific to GitHub example, but keeping for now

        var errorDescription: String? {
            switch self {
            case .invalidURL: return "Invalid URL"
            case .invalidResponse: return "Invalid response from server"
            case .userNotFound: return "User not found"
            }
        }
    }

    func fetchWeather(for city: String) async throws {
        // Simulate API call
        try await Task.sleep(for: .seconds(1))

        // In real app, use URLSession
        self.currentWeather = Weather(
            city: city,
            temperature: 72,
            condition: "Sunny",
            humidity: 45
        )

        self.forecast = generateForecast()
    }

    private func generateForecast() -> [ForecastDay] {
        var days: [ForecastDay] = []
        for i in 0..<5 {
            let date = Calendar.current.date(byAdding: .day, value: i, to: Date())!
            let tempHigh = Int.random(in: 65...85)
            let tempLow = Int.random(in: 50...60)
            let conditions = ["Sunny", "Partly Cloudy", "Rainy", "Cloudy"]
            let condition = conditions.randomElement()!
            days.append(ForecastDay(date: date, temperatureHigh: tempHigh, temperatureLow: tempLow, condition: condition))
        }
        return days
    }
}
