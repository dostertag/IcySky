import SwiftUI

struct TaskListView: View {
    let category: Category
    @State private var tasks: [Task] = []
    @State private var showingAddTaskSheet = false

    var body: some View {
        List {
            ForEach(tasks) { task in
                HStack {
                    Button {
                        toggleTaskCompletion(task: task)
                    } label: {
                        Image(systemName: task.isCompleted ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(task.isCompleted ? .green : .gray)
                    }
                    .buttonStyle(.plain) // To remove default button styling

                    Text(task.title)
                        .strikethrough(task.isCompleted)
                        .foregroundColor(task.isCompleted ? .secondary : .primary)
                }
            }
            .onDelete(perform: deleteTask)
        }
        .navigationTitle(category.name)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    showingAddTaskSheet = true
                } label: {
                    Image(systemName: "plus.circle.fill")
                }
            }
        }
        .sheet(isPresented: $showingAddTaskSheet) {
            AddTaskView(category: category, onSave: addTask)
        }
        .onAppear(perform: loadTasks)
    }

    private func loadTasks() {
        // In a real app, load tasks from persistence based on category.id
        // For now, we'll use some dummy data
        if category.name == "Work" {
            tasks = [
                Task(title: "Finish SwiftUI project", categoryId: category.id),
                Task(title: "Prepare presentation", isCompleted: true, categoryId: category.id)
            ]
        } else if category.name == "Personal" {
            tasks = [
                Task(title: "Buy groceries", categoryId: category.id),
                Task(title: "Call mom", categoryId: category.id)
            ]
        } else if category.name == "Shopping" {
            tasks = [
                Task(title: "New shoes", categoryId: category.id)
            ]
        }
    }

    private func toggleTaskCompletion(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].isCompleted.toggle()
        }
    }

    private func addTask(title: String) {
        let newTask = Task(title: title, categoryId: category.id)
        tasks.append(newTask)
        showingAddTaskSheet = false
    }

    private func deleteTask(at offsets: IndexSet) {
        tasks.remove(atOffsets: offsets)
    }
}
