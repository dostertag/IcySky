import SwiftUI

struct TemperatureConverterView: View {
    @State private var celsiusString: String = ""

    private var celsius: Double {
        return Double(celsiusString) ?? 0
    }

    private var fahrenheit: Double {
        return (celsius * 9/5) + 32
    }

    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter Celsius", text: $celsiusString)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)
                .padding()

            Text("\(celsius, specifier: "%.1f") °C is \(fahrenheit, specifier: "%.1f") °F")
                .font(.title)
        }
        .padding()
    }
}
