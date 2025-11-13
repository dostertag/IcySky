import SwiftUI

@main
struct WeatherApp: App {
    @State var weatherService = WeatherService() // Create an instance of the observable service

    var body: some Scene {
        WindowGroup {
            WeatherView()
                .environment(weatherService) // Inject the service into the environment
        }
    }
}
