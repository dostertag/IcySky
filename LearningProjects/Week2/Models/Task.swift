import Foundation

struct Task: Identifiable, Codable {
    let id: UUID
    var title: String
    var isCompleted: Bool
    var categoryId: UUID

    init(title: String, categoryId: UUID) {
        self.id = UUID()
        self.title = title
        self.isCompleted = false
        self.categoryId = categoryId
    }
}
