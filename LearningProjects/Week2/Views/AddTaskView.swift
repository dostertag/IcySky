import SwiftUI

struct AddTaskView: View {
    let category: Category
    var onSave: (String) -> Void // Closure to pass new task title back
    @Environment(\.dismiss) var dismiss // Environment value to dismiss the sheet

    @State private var newTaskTitle: String = ""

    var body: some View {
        NavigationView { // Use NavigationView for navigation bar in sheet
            Form {
                TextField("Task Title", text: $newTaskTitle)
            }
            .navigationTitle("Add New Task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss() // Dismiss the sheet
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        onSave(newTaskTitle) // Call the onSave closure
                    }
                    .disabled(newTaskTitle.isEmpty) // Disable save button if title is empty
                }
            }
        }
    }
}
