import SwiftUI

struct CategoryListView: View {
    @State private var categories: [Category] = [
        Category(name: "Work", icon: "briefcase.fill"),
        Category(name: "Personal", icon: "house.fill"),
        Category(name: "Shopping", icon: "cart.fill")
    ]

    var body: some View {
        NavigationStack {
            List(categories) { category in
                NavigationLink(value: category) {
                    HStack {
                        Image(systemName: category.icon)
                        Text(category.name)
                    }
                }
            }
            .navigationTitle("Categories")
            .navigationDestination(for: Category.self) { category in
                TaskListView(category: category)
            }
        }
    }
}
