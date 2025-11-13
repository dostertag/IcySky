import Foundation

struct ForecastDay: Identifiable {
    let id = UUID()
    let date: Date
    let temperatureHigh: Int
    let temperatureLow: Int
    let condition: String
}
