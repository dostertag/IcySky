import SwiftUI

enum ExpenseCategory: String, CaseIterable, Identifiable, Codable {
    case food = "Food"
    case transport = "Transport"
    case entertainment = "Entertainment"
    case utilities = "Utilities"
    case housing = "Housing"
    case other = "Other"

    var id: String { self.rawValue }

    var icon: String {
        switch self {
        case .food: return "fork.knife.circle.fill"
        case .transport: return "car.fill"
        case .entertainment: return "movie.fill"
        case .utilities: return "lightbulb.fill"
        case .housing: return "house.fill"
        case .other: return "tag.fill"
        }
    }

    var color: Color {
        switch self {
        case .food: return .orange
        case .transport: return .blue
        case .entertainment: return .purple
        case .utilities: return .yellow
        case .housing: return .green
        case .other: return .gray
        }
    }

    var name: String { self.rawValue }
}
