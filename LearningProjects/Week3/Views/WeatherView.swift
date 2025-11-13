import SwiftUI
import Observation // Needed for @Environment(WeatherService.self)

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
        NavigationStack {
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
            .navigationTitle("Weather App")
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
            // For now, we'll just show current weather. Forecast can be added later.
        }
    }
}
