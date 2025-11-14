import Foundation
import Observation

@Observable
final class ExpenseService {
    private(set) var expenses: [Expense] = []

    var totalExpenses: Double {
        expenses.reduce(0) { $0 + $1.amount }
    }

    init() {
        // Load dummy data for now
        loadDummyData()
    }

    func addExpense(_ expense: Expense) {
        expenses.append(expense)
        // In a real app, save to persistence here
    }

    func deleteExpense(at offsets: IndexSet) {
        expenses.remove(atOffsets: offsets)
        // In a real app, save to persistence here
    }

    private func loadDummyData() {
        expenses = [
            Expense(title: "Groceries", amount: 55.20, category: .food, date: Date().addingTimeInterval(-86400 * 2)),
            Expense(title: "Bus Ticket", amount: 3.50, category: .transport, date: Date().addingTimeInterval(-86400 * 1)),
            Expense(title: "Movie Night", amount: 25.00, category: .entertainment, date: Date()),
            Expense(title: "Electricity Bill", amount: 75.00, category: .utilities, date: Date().addingTimeInterval(-86400 * 5)),
            Expense(title: "Rent", amount: 1200.00, category: .housing, date: Date().addingTimeInterval(-86400 * 10)),
            Expense(title: "Coffee", amount: 4.50, category: .food, date: Date().addingTimeInterval(-86400 * 3)),
            Expense(title: "Dinner", amount: 40.00, category: .food, date: Date().addingTimeInterval(-86400 * 1)),
            Expense(title: "Uber", amount: 15.00, category: .transport, date: Date().addingTimeInterval(-86400 * 0.5)),
        ]
    }
}
