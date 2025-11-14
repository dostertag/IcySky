# iOS Development Learning Plan
## A 6-Week Hands-On Curriculum Using IcySky as Reference

---

## Overview

This learning plan takes you from iOS development basics to building real-world applications using SwiftUI and modern Swift features. You'll reference the IcySky codebase to see professional patterns in action while building your own projects.

**Total Duration**: 6 weeks (5-10 hours per week)

**Prerequisites**:
- Basic programming knowledge (any language)
- Mac with Xcode installed
- Enthusiasm to learn!

**Learning Philosophy**:
- Learn by doing: Build real projects
- Study professional code: Reference IcySky for patterns
- Iterate and improve: Start simple, add complexity

---

## Week 1: SwiftUI Fundamentals

### Learning Objectives
- Understand SwiftUI's declarative syntax
- Master basic views and layouts
- Learn state management with @State
- Build your first interactive app

### Study Guide: IcySky References

**Files to Study**:
1. `App/IcySkyApp.swift` - See how an app starts
2. `Packages/Features/Sources/AuthUI/AuthView.swift` - Simple form with state
3. `Packages/Features/Sources/DesignSystem/Components/HeaderView.swift` - Basic view composition

**Concepts to Understand**:
```swift
// View Protocol - Every UI element is a View
struct MyView: View {
    var body: some View {
        Text("Hello")
    }
}

// @State - Local mutable state
@State private var count: Int = 0

// View Modifiers - Chain methods to style views
Text("Hello")
    .font(.title)
    .foregroundColor(.blue)
    .padding()
```

### Hands-On Project: Counter App

**Goal**: Build a simple counter app with increment/decrement buttons

**Requirements**:
1. Display a number (starts at 0)
2. Button to increment (+1)
3. Button to decrement (-1)
4. Button to reset to 0
5. Change text color when number is positive (green) or negative (red)

**Learning Points**:
- Use `@State` for the counter value
- Use `Button` with actions
- Use `if` statements or ternary operators for conditional styling
- Practice VStack/HStack for layout

**Starter Code**:
```swift
import SwiftUI

struct CounterView: View {
    @State private var count: Int = 0

    var body: some View {
        VStack(spacing: 20) {
            Text("\(count)")
                .font(.system(size: 72, weight: .bold))
                .foregroundColor(count > 0 ? .green : count < 0 ? .red : .primary)

            HStack(spacing: 20) {
                Button("-") {
                    count -= 1
                }
                .buttonStyle(.bordered)

                Button("Reset") {
                    count = 0
                }
                .buttonStyle(.borderedProminent)

                Button("+") {
                    count += 1
                }
                .buttonStyle(.bordered)
            }
            .font(.title)
        }
        .padding()
    }
}
```

### Additional Exercises

**Exercise 1.1: Temperature Converter**
- Input field for Celsius
- Automatically display Fahrenheit
- Formula: F = (C × 9/5) + 32

**Exercise 1.2: Tip Calculator**
- Input: Bill amount
- Buttons: 15%, 18%, 20% tip
- Display: Tip amount and total

**Exercise 1.3: Color Picker**
- Three sliders: Red, Green, Blue (0-255)
- Display a rectangle with the selected color
- Show RGB values

### Key Concepts Checklist
- [ ] Understand View protocol and body property
- [ ] Use @State for mutable state
- [ ] Work with Text, Button, Image views
- [ ] Use VStack, HStack, ZStack for layout
- [ ] Apply modifiers (.font, .padding, .foregroundColor, etc.)
- [ ] Handle button actions
- [ ] Use conditional logic in views

### Resources
- Apple's SwiftUI Tutorials: https://developer.apple.com/tutorials/swiftui
- SwiftUI Views Documentation: https://developer.apple.com/documentation/swiftui/views

---

## Week 2: Navigation & Lists

### Learning Objectives
- Work with List and ForEach
- Implement navigation with NavigationStack
- Understand Identifiable protocol
- Build multi-screen apps

### Study Guide: IcySky References

**Files to Study**:
1. `Packages/Features/Sources/FeedUI/List/FeedsListView.swift` - List implementation
2. `Packages/Model/Sources/Destinations/RouterDestination.swift` - Navigation destinations
3. `App/AppTabView.swift` - Tab-based navigation

**Concepts to Understand**:
```swift
// Lists with ForEach
List {
    ForEach(items) { item in
        Text(item.name)
    }
}

// Navigation Stack
NavigationStack {
    List {
        NavigationLink("Details", value: item)
    }
    .navigationDestination(for: Item.self) { item in
        DetailView(item: item)
    }
}

// Identifiable Protocol
struct Item: Identifiable {
    let id = UUID()
    let name: String
}
```

### Hands-On Project: Task Manager App

**Goal**: Build a todo list app with multiple lists and detail views

**Requirements**:
1. Main screen shows list of task categories
2. Tap category to see tasks in that category
3. Add new tasks with a "+" button
4. Mark tasks as complete with checkmarks
5. Delete tasks with swipe-to-delete

**App Structure**:
```
TaskManagerApp
├── Models/
│   ├── Task.swift
│   └── Category.swift
├── Views/
│   ├── CategoryListView.swift
│   ├── TaskListView.swift
│   └── AddTaskView.swift
└── TaskManagerApp.swift
```

**Model Example**:
```swift
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

struct Category: Identifiable, Codable {
    let id: UUID
    var name: String
    var icon: String

    init(name: String, icon: String) {
        self.id = UUID()
        self.name = name
        self.icon = icon
    }
}
```

**View Starter**:
```swift
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
```

### Additional Exercises

**Exercise 2.1: Recipe Book**
- List of recipe categories (Breakfast, Lunch, Dinner)
- Each category shows list of recipes
- Recipe detail view shows ingredients and instructions

**Exercise 2.2: Contact Directory**
- Alphabetically sorted list of contacts
- Search functionality
- Detail view with contact info
- Use `.searchable()` modifier

**Exercise 2.3: Settings Screen**
- Grouped list with sections
- Toggle switches for preferences
- Navigation links to sub-settings
- Study IcySky's `SettingsUI` module

### Key Concepts Checklist
- [ ] Create List views with static and dynamic content
- [ ] Use ForEach with Identifiable items
- [ ] Implement NavigationStack and NavigationLink
- [ ] Use navigationDestination for type-safe navigation
- [ ] Add navigation titles and toolbars
- [ ] Implement swipe actions (.swipeActions)
- [ ] Handle list editing (delete, move)
- [ ] Work with SF Symbols for icons

### Resources
- NavigationStack Documentation: https://developer.apple.com/documentation/swiftui/navigationstack
- List Documentation: https://developer.apple.com/documentation/swiftui/list

---

## Week 3: State Management & Architecture

### Learning Objectives
- Master @Environment for dependency injection
- Understand @Observable for shared state
- Learn the "no ViewModel" philosophy
- Structure apps with proper architecture

### Study Guide: IcySky References

**Files to Study**:
1. `App/AppState.swift` - Enum-based app state
2. `Packages/Model/Sources/User/CurrentUser.swift` - @Observable class
3. `Packages/Model/Sources/Models/PostContext.swift` - Observable with async operations
4. `App/IcySkyApp.swift` - Environment injection pattern

**Concepts to Understand**:
```swift
// @Observable - Shared state that views can observe
@Observable
class DataService {
    var items: [Item] = []

    func loadItems() async {
        // Load data
        self.items = loadedItems
    }
}

// @Environment - Access shared objects
struct MyView: View {
    @Environment(DataService.self) var service

    var body: some View {
        List(service.items) { item in
            Text(item.name)
        }
    }
}

// Inject into environment
MyView()
    .environment(DataService())

// Enum-based view states
enum ViewState {
    case loading
    case loaded([Item])
    case error(String)
}
```

### Hands-On Project: Weather App

**Goal**: Build a weather app that fetches data and manages state properly

**Requirements**:
1. Search for cities
2. Display current weather
3. Show 5-day forecast
4. Handle loading and error states
5. Save favorite cities
6. Use proper architecture (no ViewModels!)

**Architecture**:
```
WeatherApp/
├── Models/
│   ├── Weather.swift
│   ├── City.swift
│   └── Forecast.swift
├── Services/
│   ├── WeatherService.swift
│   └── LocationService.swift
├── Views/
│   ├── CitySearchView.swift
│   ├── WeatherView.swift
│   └── ForecastView.swift
└── WeatherApp.swift
```

**Service Example (Study IcySky's BSkyClient.swift)**:
```swift
@Observable
final class WeatherService {
    private(set) var currentWeather: Weather?
    private(set) var forecast: [ForecastDay] = []

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
}

struct Weather {
    let city: String
    let temperature: Int
    let condition: String
    let humidity: Int
}
```

**View Example (Study IcySky's FeedsListView.swift)**:
```swift
struct WeatherView: View {
    @Environment(WeatherService.self) var weatherService
    @State private var cityName: String = ""
    @State private var viewState: ViewState = .initial

    enum ViewState {
        case initial
        case loading
        case loaded
        case error(String)
    }

    var body: some View {
        VStack {
            searchField

            switch viewState {
            case .initial:
                ContentUnavailableView(
                    "Search for a City",
                    systemImage: "magnifyingglass"
                )
            case .loading:
                ProgressView("Loading weather...")
            case .loaded:
                weatherContent
            case .error(let message):
                ContentUnavailableView(
                    "Error",
                    systemImage: "exclamationmark.triangle",
                    description: Text(message)
                )
            }
        }
    }

    private var searchField: some View {
        HStack {
            TextField("Enter city name", text: $cityName)
                .textFieldStyle(.roundedBorder)

            Button("Search") {
                Task {
                    viewState = .loading
                    do {
                        try await weatherService.fetchWeather(for: cityName)
                        viewState = .loaded
                    } catch {
                        viewState = .error(error.localizedDescription)
                    }
                }
            }
            .buttonStyle(.borderedProminent)
            .disabled(cityName.isEmpty)
        }
        .padding()
    }

    private var weatherContent: some View {
        VStack(spacing: 20) {
            if let weather = weatherService.currentWeather {
                Text(weather.city)
                    .font(.largeTitle)

                Text("\(weather.temperature)°F")
                    .font(.system(size: 72))

                Text(weather.condition)
                    .font(.title2)

                Text("Humidity: \(weather.humidity)%")
                    .foregroundStyle(.secondary)
            }
        }
    }
}
```

**App Setup (Study IcySky's IcySkyApp.swift)**:
```swift
@main
struct WeatherApp: App {
    @State var weatherService = WeatherService()

    var body: some Scene {
        WindowGroup {
            WeatherView()
                .environment(weatherService)
        }
    }
}
```

### Additional Exercises

**Exercise 3.1: News Reader**
- Observable NewsService to fetch articles
- Enum-based states: loading, loaded, error
- Environment injection pattern
- Article list and detail views

**Exercise 3.2: Movie Database**
- MovieService with search and favorites
- Multiple views sharing same service via @Environment
- Optimistic updates when favoriting (study PostContext.swift)

**Exercise 3.3: Note-Taking App**
- NoteService as @Observable
- Automatic save functionality
- Multiple views showing same notes
- Study how IcySky shares CurrentUser across views

### Key Concepts Checklist
- [ ] Create @Observable classes for shared state
- [ ] Use @Environment to inject and access services
- [ ] Implement enum-based view states
- [ ] Structure apps without ViewModels
- [ ] Handle async operations in Observable classes
- [ ] Understand when to use @State vs @Environment
- [ ] Practice proper separation of concerns
- [ ] Use Task {} for async operations from synchronous context

### Resources
- Observation Framework: https://developer.apple.com/documentation/observation
- State Management: https://developer.apple.com/documentation/swiftui/managing-model-data-in-your-app

---

## Week 4: Networking & Data Persistence

### Learning Objectives
- Make real API calls with URLSession
- Parse JSON with Codable
- Handle errors gracefully
- Persist data locally
- Understand async/await patterns

### Study Guide: IcySky References

**Files to Study**:
1. `Packages/Model/Sources/Client/BSkyClient.swift` - API client wrapper
2. `Packages/Model/Sources/Auth/Auth.swift` - Async operations and error handling
3. `Packages/Model/Sources/Models/` - Codable models
4. Study how IcySky uses UserDefaults and Keychain

**Concepts to Understand**:
```swift
// Codable for JSON parsing
struct User: Codable {
    let id: Int
    let name: String
    let email: String
}

// URLSession async/await
func fetchUser(id: Int) async throws -> User {
    let url = URL(string: "https://api.example.com/users/\(id)")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let user = try JSONDecoder().decode(User.self, from: data)
    return user
}

// UserDefaults for simple persistence
UserDefaults.standard.set(value, forKey: "key")
let value = UserDefaults.standard.string(forKey: "key")

// FileManager for document storage
let documentsURL = FileManager.default.urls(
    for: .documentDirectory,
    in: .userDomainMask
)[0]
```

### Hands-On Project: GitHub Repo Browser

**Goal**: Build an app that fetches and displays GitHub repositories using the real GitHub API

**Requirements**:
1. Search for GitHub users
2. Display user profile (avatar, name, bio)
3. Show user's public repositories
4. Display repo details (stars, forks, language)
5. Save favorite repos locally
6. Handle loading states and errors properly

**API Endpoints**:
- User: `https://api.github.com/users/{username}`
- Repos: `https://api.github.com/users/{username}/repos`

**Models**:
```swift
struct GitHubUser: Codable, Identifiable {
    let id: Int
    let login: String
    let name: String?
    let bio: String?
    let avatarUrl: String
    let publicRepos: Int

    enum CodingKeys: String, CodingKey {
        case id, login, name, bio
        case avatarUrl = "avatar_url"
        case publicRepos = "public_repos"
    }
}

struct Repository: Codable, Identifiable {
    let id: Int
    let name: String
    let description: String?
    let language: String?
    let stargazersCount: Int
    let forksCount: Int
    let htmlUrl: String

    enum CodingKeys: String, CodingKey {
        case id, name, description, language
        case stargazersCount = "stargazers_count"
        case forksCount = "forks_count"
        case htmlUrl = "html_url"
    }
}
```

**Network Service** (Study BSkyClient.swift pattern):
```swift
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
```

**Persistence Service**:
```swift
@Observable
final class FavoritesService {
    private let favoritesKey = "favoriteRepos"
    private(set) var favorites: [Repository] = []

    init() {
        loadFavorites()
    }

    func toggleFavorite(_ repo: Repository) {
        if let index = favorites.firstIndex(where: { $0.id == repo.id }) {
            favorites.remove(at: index)
        } else {
            favorites.append(repo)
        }
        saveFavorites()
    }

    func isFavorite(_ repo: Repository) -> Bool {
        favorites.contains(where: { $0.id == repo.id })
    }

    private func saveFavorites() {
        if let encoded = try? JSONEncoder().encode(favorites) {
            UserDefaults.standard.set(encoded, forKey: favoritesKey)
        }
    }

    private func loadFavorites() {
        guard let data = UserDefaults.standard.data(forKey: favoritesKey),
              let decoded = try? JSONDecoder().decode([Repository].self, from: data) else {
            return
        }
        favorites = decoded
    }
}
```

**User Search View**:
```swift
struct UserSearchView: View {
    @Environment(GitHubService.self) var service
    @State private var username: String = ""
    @State private var viewState: ViewState = .initial

    enum ViewState {
        case initial
        case loading
        case loaded(GitHubUser, [Repository])
        case error(String)
    }

    var body: some View {
        NavigationStack {
            VStack {
                searchBar

                switch viewState {
                case .initial:
                    ContentUnavailableView(
                        "Search GitHub Users",
                        systemImage: "magnifyingglass",
                        description: Text("Enter a username to get started")
                    )

                case .loading:
                    ProgressView("Fetching data...")

                case .loaded(let user, let repos):
                    ScrollView {
                        userProfileView(user)
                        repositoriesSection(repos)
                    }

                case .error(let message):
                    ContentUnavailableView(
                        "Error",
                        systemImage: "exclamationmark.triangle",
                        description: Text(message)
                    )
                }
            }
            .navigationTitle("GitHub Browser")
        }
    }

    private var searchBar: some View {
        HStack {
            TextField("GitHub username", text: $username)
                .textFieldStyle(.roundedBorder)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()

            Button("Search") {
                searchUser()
            }
            .buttonStyle(.borderedProminent)
            .disabled(username.isEmpty)
        }
        .padding()
    }

    private func searchUser() {
        Task {
            viewState = .loading
            do {
                async let user = service.fetchUser(username: username)
                async let repos = service.fetchRepositories(for: username)

                let (fetchedUser, fetchedRepos) = try await (user, repos)
                viewState = .loaded(fetchedUser, fetchedRepos)
            } catch {
                viewState = .error(error.localizedDescription)
            }
        }
    }

    private func userProfileView(_ user: GitHubUser) -> some View {
        VStack(spacing: 12) {
            AsyncImage(url: URL(string: user.avatarUrl)) { image in
                image
                    .resizable()
                    .scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 120, height: 120)
            .clipShape(Circle())

            Text(user.name ?? user.login)
                .font(.title)
                .bold()

            if let bio = user.bio {
                Text(bio)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .multilineTextAlignment(.center)
            }

            Text("\(user.publicRepos) public repositories")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
    }

    private func repositoriesSection(_ repos: [Repository]) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Repositories")
                .font(.headline)
                .padding(.horizontal)

            ForEach(repos) { repo in
                RepositoryRowView(repo: repo)
            }
        }
    }
}
```

### Additional Exercises

**Exercise 4.1: Integrate Real Weather API**
- Sign up for OpenWeatherMap API (free tier)
- Update Week 3's weather app to use real data
- Handle API errors and rate limiting

**Exercise 4.2: Offline-First Notes App**
- Save notes to FileManager documents directory
- Load notes on app launch
- Implement file-based persistence
- Add search functionality

**Exercise 4.3: Pokemon Explorer**
- Use PokeAPI (https://pokeapi.co/)
- List pokemon with pagination
- Show details with stats
- Cache images (study IcySky's image caching with Nuke)

### Key Concepts Checklist
- [ ] Make API calls with URLSession and async/await
- [ ] Parse JSON with Codable protocol
- [ ] Handle CodingKeys for snake_case to camelCase
- [ ] Implement proper error handling
- [ ] Use parallel async operations (async let)
- [ ] Save data with UserDefaults
- [ ] Work with FileManager for document storage
- [ ] Encode/decode data with JSONEncoder/JSONDecoder
- [ ] Handle loading states during network calls
- [ ] Display meaningful error messages to users

### Resources
- URLSession Documentation: https://developer.apple.com/documentation/foundation/urlsession
- Codable Protocol: https://developer.apple.com/documentation/swift/codable
- Swift Concurrency: https://docs.swift.org/swift-book/LanguageGuide/Concurrency.html

---

## Week 5: Advanced Features & Polish

### Learning Objectives
- Implement advanced SwiftUI features
- Add animations and transitions
- Work with gestures
- Implement custom modifiers
- Master TabView and sheets

### Study Guide: IcySky References

**Files to Study**:
1. `Packages/Features/Sources/DesignSystem/` - Custom components and modifiers
2. `App/Destinations/SheetDestinations.swift` - Modal presentations
3. `Packages/Features/Sources/MediaUI/` - Gesture handling
4. `Packages/Features/Sources/PostUI/Row/PostRowActionsView.swift` - Animations

**Concepts to Understand**:
```swift
// Animations
withAnimation(.spring()) {
    isExpanded.toggle()
}

// Transitions
.transition(.move(edge: .bottom).combined(with: .opacity))

// Custom ViewModifier
struct CardModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.background)
            .cornerRadius(12)
            .shadow(radius: 2)
    }
}

extension View {
    func cardStyle() -> some View {
        modifier(CardModifier())
    }
}

// Sheet presentation
.sheet(isPresented: $showingSheet) {
    DetailView()
}

// Gestures
.onTapGesture { }
.gesture(
    DragGesture()
        .onChanged { value in }
        .onEnded { value in }
)
```

### Hands-On Project: Expense Tracker

**Goal**: Build a polished expense tracking app with advanced UI features

**Requirements**:
1. Add expenses with amount, category, date, notes
2. Display expenses in categorized lists
3. Show spending charts/statistics
4. Swipe gestures for edit/delete
5. Filter by date range
6. Smooth animations throughout
7. Export data functionality

**Features to Implement**:

**1. Custom Card Component**:
```swift
struct ExpenseCardModifier: ViewModifier {
    let category: ExpenseCategory

    func body(content: Content) -> some View {
        content
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(category.color.opacity(0.1))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(category.color, lineWidth: 1)
            )
    }
}

extension View {
    func expenseCard(category: ExpenseCategory) -> some View {
        modifier(ExpenseCardModifier(category: category))
    }
}
```

**2. Animated Expense Row**:
```swift
struct ExpenseRowView: View {
    let expense: Expense
    @State private var isExpanded = false

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: expense.category.icon)
                    .foregroundColor(expense.category.color)

                VStack(alignment: .leading) {
                    Text(expense.title)
                        .font(.headline)
                    Text(expense.date, style: .date)
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }

                Spacer()

                Text("$\(expense.amount, specifier: "%.2f")")
                    .font(.headline)
                    .foregroundColor(expense.category.color)

                Image(systemName: "chevron.down")
                    .rotationEffect(.degrees(isExpanded ? 180 : 0))
                    .animation(.spring(), value: isExpanded)
            }

            if isExpanded, let notes = expense.notes {
                Text(notes)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .padding(.top, 4)
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
        }
        .padding()
        .background(.background)
        .cornerRadius(12)
        .shadow(radius: 2)
        .onTapGesture {
            withAnimation(.spring()) {
                isExpanded.toggle()
            }
        }
    }
}
```

**3. Add Expense Sheet**:
```swift
struct AddExpenseView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(ExpenseService.self) var service

    @State private var title: String = ""
    @State private var amount: String = ""
    @State private var category: ExpenseCategory = .food
    @State private var date: Date = .now
    @State private var notes: String = ""

    var body: some View {
        NavigationStack {
            Form {
                Section("Details") {
                    TextField("Title", text: $title)
                    TextField("Amount", text: $amount)
                        .keyboardType(.decimalPad)
                    DatePicker("Date", selection: $date, displayedComponents: .date)
                }

                Section("Category") {
                    Picker("Category", selection: $category) {
                        ForEach(ExpenseCategory.allCases) { category in
                            Label(category.name, systemImage: category.icon)
                                .tag(category)
                        }
                    }
                    .pickerStyle(.menu)
                }

                Section("Notes") {
                    TextEditor(text: $notes)
                        .frame(height: 100)
                }
            }
            .navigationTitle("Add Expense")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        saveExpense()
                    }
                    .disabled(!isValid)
                }
            }
        }
    }

    private var isValid: Bool {
        !title.isEmpty && Double(amount) != nil
    }

    private func saveExpense() {
        guard let amountValue = Double(amount) else { return }

        let expense = Expense(
            title: title,
            amount: amountValue,
            category: category,
            date: date,
            notes: notes.isEmpty ? nil : notes
        )

        service.addExpense(expense)
        dismiss()
    }
}
```

**4. Statistics View with Charts**:
```swift
import Charts

struct StatisticsView: View {
    @Environment(ExpenseService.self) var service

    var categoryTotals: [CategoryTotal] {
        Dictionary(grouping: service.expenses) { $0.category }
            .map { category, expenses in
                CategoryTotal(
                    category: category,
                    total: expenses.reduce(0) { $0 + $1.amount }
                )
            }
            .sorted { $0.total > $1.total }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 24) {
                totalSpendingCard
                categoryChart
                categoryBreakdown
            }
            .padding()
        }
        .navigationTitle("Statistics")
    }

    private var totalSpendingCard: some View {
        VStack {
            Text("Total Spending")
                .font(.headline)
                .foregroundStyle(.secondary)

            Text("$\(service.totalExpenses, specifier: "%.2f")")
                .font(.system(size: 48, weight: .bold))
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.blue.opacity(0.1))
        .cornerRadius(12)
    }

    private var categoryChart: some View {
        Chart(categoryTotals) { item in
            BarMark(
                x: .value("Amount", item.total),
                y: .value("Category", item.category.name)
            )
            .foregroundStyle(item.category.color)
        }
        .frame(height: 300)
        .padding()
        .background(.background)
        .cornerRadius(12)
    }

    private var categoryBreakdown: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Breakdown by Category")
                .font(.headline)

            ForEach(categoryTotals) { item in
                HStack {
                    Image(systemName: item.category.icon)
                        .foregroundColor(item.category.color)

                    Text(item.category.name)

                    Spacer()

                    Text("$\(item.total, specifier: "%.2f")")
                        .bold()
                }
                .padding(.vertical, 4)
            }
        }
        .padding()
        .background(.background)
        .cornerRadius(12)
    }
}

struct CategoryTotal: Identifiable {
    let id = UUID()
    let category: ExpenseCategory
    let total: Double
}
```

### Additional Exercises

**Exercise 5.1: Add Pull-to-Refresh**
- Implement `.refreshable` modifier
- Add haptic feedback
- Animate refresh indicator

**Exercise 5.2: Custom Tab Bar**
- Study IcySky's AppTabView
- Create custom tab bar with animations
- Add badge notifications

**Exercise 5.3: Swipe Gestures**
- Implement swipe-to-delete
- Add swipe-to-edit
- Custom swipe actions with icons

### Key Concepts Checklist
- [ ] Use withAnimation for smooth transitions
- [ ] Implement custom ViewModifiers
- [ ] Work with .sheet and .fullScreenCover
- [ ] Create reusable custom components
- [ ] Use Charts framework for data visualization
- [ ] Handle gestures (tap, drag, long press)
- [ ] Implement smooth transitions
- [ ] Use toolbar and navigation properly
- [ ] Add haptic feedback
- [ ] Create polished, production-ready UI

### Resources
- Animation Documentation: https://developer.apple.com/documentation/swiftui/animation
- Charts Framework: https://developer.apple.com/documentation/charts
- Gestures: https://developer.apple.com/documentation/swiftui/gestures

---

## Week 6: Final Project & Best Practices

### Learning Objectives
- Build a complete, polished app
- Implement authentication flow
- Handle app lifecycle
- Add testing
- Follow iOS best practices
- Prepare for App Store

### Study Guide: IcySky References

**Study the Entire Architecture**:
1. Complete authentication flow (Auth module)
2. App lifecycle handling (IcySkyApp.swift)
3. Environment setup and dependency injection
4. Package structure and organization
5. Testing examples in Features/Tests

**Key Patterns to Master**:
```swift
// App lifecycle
@Environment(\.scenePhase) var scenePhase

.task(id: scenePhase) {
    if scenePhase == .active {
        await refreshData()
    }
}

// AsyncStream for reactive updates
public let configurationUpdates: AsyncStream<ATProtocolConfiguration?>

.task {
    for await configuration in auth.configurationUpdates {
        // Handle configuration changes
    }
}

// Proper error handling
enum AppError: LocalizedError {
    case networkError
    case authenticationFailed
    case invalidData

    var errorDescription: String? {
        switch self {
        case .networkError: return "Network connection failed"
        case .authenticationFailed: return "Authentication failed"
        case .invalidData: return "Invalid data received"
        }
    }
}
```

### Final Project: Social Media Dashboard

**Goal**: Build a complete social media dashboard app that demonstrates all learned concepts

**Requirements**:

**Core Features**:
1. User authentication (email/password)
2. Multiple social feeds (Twitter, Reddit, etc. via APIs)
3. Post timeline with infinite scroll
4. Post details with comments
5. Search functionality
6. User profiles
7. Favorites/bookmarks
8. Settings and preferences
9. Dark mode support
10. Offline support with local caching

**Technical Requirements**:
- Proper package structure (Features + Model)
- @Observable for state management
- Environment-based dependency injection
- AsyncStream for reactive updates
- Proper error handling
- Unit tests for services
- UI tests for critical flows

**Project Structure**:
```
SocialDashboard/
├── App/
│   ├── SocialDashboardApp.swift
│   ├── AppState.swift
│   ├── AppTabView.swift
│   └── Destinations/
├── Packages/
│   ├── Features/
│   │   ├── Package.swift
│   │   └── Sources/
│   │       ├── AuthUI/
│   │       ├── FeedUI/
│   │       ├── PostUI/
│   │       ├── ProfileUI/
│   │       ├── SearchUI/
│   │       ├── SettingsUI/
│   │       └── DesignSystem/
│   └── Model/
│       ├── Package.swift
│       └── Sources/
│           ├── Auth/
│           ├── Client/
│           ├── Models/
│           ├── User/
│           ├── Cache/
│           └── Destinations/
└── Tests/
```

**Implementation Steps**:

**Phase 1: Setup (Day 1)**
1. Create project structure
2. Set up packages
3. Define models and destinations
4. Create app entry point

**Phase 2: Authentication (Day 2)**
1. Build Auth service with keychain
2. Create login/signup views
3. Implement AsyncStream pattern
4. Handle auth state changes

**Phase 3: Feed System (Days 3-4)**
1. Build API client services
2. Create feed list view
3. Implement infinite scroll
4. Add pull-to-refresh
5. Cache feed data locally

**Phase 4: Post Details (Day 5)**
1. Create post detail view
2. Fetch and display comments
3. Implement like/share actions
4. Add image viewing

**Phase 5: Additional Features (Day 6)**
1. User profile views
2. Search functionality
3. Bookmarks/favorites
4. Settings screen

**Phase 6: Polish (Day 7)**
1. Add animations and transitions
2. Implement error handling
3. Add loading states
4. Dark mode support
5. Accessibility labels

**Sample Code - App Entry Point**:
```swift
@main
struct SocialDashboardApp: App {
    @Environment(\.scenePhase) var scenePhase

    @State var appState: AppState = .resuming
    @State var auth: AuthService = .init()
    @State var router: AppRouter = .init(initialTab: .feed)

    var body: some Scene {
        WindowGroup {
            Group {
                switch appState {
                case .resuming:
                    ProgressView()
                        .containerRelativeFrame([.horizontal, .vertical])

                case .authenticated(let services):
                    MainTabView()
                        .environment(services.apiClient)
                        .environment(services.currentUser)
                        .environment(services.cacheService)
                        .environment(auth)
                        .environment(router)

                case .unauthenticated:
                    LoginView()
                        .environment(auth)

                case .error(let error):
                    ErrorView(error: error)
                }
            }
            .task(id: scenePhase) {
                if scenePhase == .active {
                    await auth.refresh()
                }
            }
            .task {
                for await authState in auth.authStateUpdates {
                    await handleAuthStateChange(authState)
                }
            }
        }
    }

    private func handleAuthStateChange(_ state: AuthState) async {
        switch state {
        case .authenticated(let token):
            do {
                let services = try await initializeServices(token: token)
                appState = .authenticated(services)
            } catch {
                appState = .error(error)
            }

        case .unauthenticated:
            appState = .unauthenticated

        case .error(let error):
            appState = .error(error)
        }
    }

    private func initializeServices(token: String) async throws -> AppServices {
        let apiClient = APIClient(token: token)
        let currentUser = try await CurrentUser(apiClient: apiClient)
        let cacheService = CacheService()

        return AppServices(
            apiClient: apiClient,
            currentUser: currentUser,
            cacheService: cacheService
        )
    }
}

struct AppServices {
    let apiClient: APIClient
    let currentUser: CurrentUser
    let cacheService: CacheService
}

enum AppState {
    case resuming
    case authenticated(AppServices)
    case unauthenticated
    case error(Error)
}
```

### Testing Your App

**Unit Test Example**:
```swift
import Testing
@testable import Model

struct AuthServiceTests {
    @Test func testLoginSuccess() async throws {
        let auth = AuthService()

        // Mock successful login
        try await auth.login(email: "test@example.com", password: "password")

        #expect(auth.isAuthenticated == true)
        #expect(auth.currentToken != nil)
    }

    @Test func testLoginFailure() async {
        let auth = AuthService()

        do {
            try await auth.login(email: "invalid", password: "wrong")
            Issue.record("Expected login to throw error")
        } catch {
            // Expected to throw
            #expect(error is AuthService.AuthError)
        }
    }
}
```

### Additional Exercises

**Exercise 6.1: Add Biometric Authentication**
- Use LocalAuthentication framework
- Face ID / Touch ID for quick login
- Study iOS security best practices

**Exercise 6.2: Implement Share Extension**
- Create share sheet integration
- Share posts to other apps
- Handle incoming shares

**Exercise 6.3: Add Widgets**
- Create home screen widgets
- Show recent posts
- Update widget timeline

### Key Concepts Checklist
- [ ] Complete authentication flow with persistence
- [ ] App lifecycle management
- [ ] AsyncStream for reactive state
- [ ] Proper package architecture
- [ ] Environment-based dependency injection
- [ ] Error handling throughout app
- [ ] Local caching and persistence
- [ ] Unit and UI testing
- [ ] Accessibility support
- [ ] Dark mode implementation
- [ ] Production-ready code quality

### Resources
- App Architecture: https://developer.apple.com/documentation/swiftui/app-organization
- Testing in Xcode: https://developer.apple.com/documentation/xctest
- App Store Guidelines: https://developer.apple.com/app-store/review/guidelines/

---

## Beyond Week 6: Next Steps

### Continue Learning

**1. Advanced SwiftUI**
- Custom layout with Layout protocol
- GeometryReader and coordinate spaces
- Advanced animations with TimelineView
- Custom transitions

**2. iOS Frameworks**
- Core Data for complex data models
- CloudKit for sync across devices
- Core Location for location services
- MapKit for maps
- StoreKit for in-app purchases

**3. Performance Optimization**
- Instruments for profiling
- Memory management
- Launch time optimization
- Background tasks

**4. Distribution**
- TestFlight beta testing
- App Store submission
- App Store Connect
- Marketing and ASO

### Project Ideas

**Beginner Projects**:
- Flashcard app
- Habit tracker
- Unit converter
- Pomodoro timer
- BMI calculator

**Intermediate Projects**:
- Budget manager
- Recipe organizer
- Workout tracker
- Reading list
- Password generator

**Advanced Projects**:
- Chat application
- Photo editor
- Music player
- Transit app
- Social network clone

### Study Resources

**Official Apple Resources**:
- WWDC Videos: https://developer.apple.com/videos/
- SwiftUI Tutorials: https://developer.apple.com/tutorials/swiftui
- Swift Documentation: https://docs.swift.org/swift-book/
- Human Interface Guidelines: https://developer.apple.com/design/human-interface-guidelines/

**Community Resources**:
- Hacking with Swift: https://www.hackingwithswift.com
- Swift by Sundell: https://www.swiftbysundell.com
- iOS Dev Weekly: https://iosdevweekly.com
- r/iOSProgramming: https://reddit.com/r/iOSProgramming

**Books**:
- "SwiftUI by Tutorials" by raywenderlich.com
- "iOS Programming: The Big Nerd Ranch Guide"
- "Thinking in SwiftUI" by Chris Eidhof

### Contributing to Open Source

Study and contribute to projects like IcySky:
1. Read the codebase thoroughly
2. Fix small bugs or typos
3. Add tests
4. Improve documentation
5. Propose new features

### Building Your Portfolio

**Tips**:
1. Publish apps to the App Store
2. Maintain a GitHub with clean code
3. Write blog posts about what you learned
4. Create demo videos of your apps
5. Contribute to open source
6. Build apps that solve real problems

---

## Progress Tracking

### Week 1: SwiftUI Fundamentals
- [ ] Complete counter app
- [ ] Complete temperature converter
- [ ] Complete tip calculator
- [ ] Complete color picker
- [ ] Understand all week 1 concepts

### Week 2: Navigation & Lists
- [ ] Complete task manager app
- [ ] Implement all navigation features
- [ ] Add swipe-to-delete
- [ ] Complete recipe book exercise
- [ ] Understand all week 2 concepts

### Week 3: State Management
- [ ] Complete weather app (mock data)
- [ ] Implement @Observable pattern
- [ ] Use @Environment properly
- [ ] Complete news reader exercise
- [ ] Understand all week 3 concepts

### Week 4: Networking & Persistence
- [ ] Complete GitHub browser app
- [ ] Make real API calls
- [ ] Implement data persistence
- [ ] Complete Pokemon explorer
- [ ] Understand all week 4 concepts

### Week 5: Advanced Features
- [ ] Complete expense tracker app
- [ ] Implement animations
- [ ] Create custom modifiers
- [ ] Add charts and statistics
- [ ] Understand all week 5 concepts

### Week 6: Final Project
- [ ] Complete social dashboard app
- [ ] Implement all core features
- [ ] Add tests
- [ ] Polish UI/UX
- [ ] Deploy to TestFlight

---

## Tips for Success

1. **Code Every Day**: Even 30 minutes makes a difference
2. **Build Real Projects**: Don't just follow tutorials
3. **Read IcySky Code**: Learn from production-quality code
4. **Ask Questions**: Join communities, ask for help
5. **Debug Mindfully**: Understand errors, don't just fix them
6. **Refactor Often**: Improve code as you learn better patterns
7. **Test Your Code**: Write tests to understand how things work
8. **Stay Current**: iOS changes fast, stay up to date
9. **Have Fun**: Build things you're excited about!

---

## Conclusion

This learning plan gives you a structured path from complete beginner to confident iOS developer. The IcySky codebase serves as your reference for professional patterns and best practices.

Remember:
- Everyone starts somewhere
- Mistakes are learning opportunities
- Build things that interest you
- The iOS community is supportive
- Keep practicing and you'll improve

Good luck on your iOS development journey! 🚀

---

*This learning plan is designed to be used alongside the IcySky codebase. Reference the specific files mentioned throughout as examples of professional iOS development.*
