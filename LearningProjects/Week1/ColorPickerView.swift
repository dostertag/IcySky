import SwiftUI

struct ColorPickerView: View {
    @State private var redValue: Double = 0
    @State private var greenValue: Double = 0
    @State private var blueValue: Double = 0

    var body: some View {
        VStack(spacing: 20) {
            Rectangle()
                .fill(Color(red: redValue / 255, green: greenValue / 255, blue: blueValue / 255))
                .frame(width: 200, height: 200)
                .border(Color.gray, width: 1)

            VStack(alignment: .leading) {
                Slider(value: $redValue, in: 0...255, step: 1) {
                    Text("Red")
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("255")
                }
                .tint(.red)
                Text("Red: \(Int(redValue))")

                Slider(value: $greenValue, in: 0...255, step: 1) {
                    Text("Green")
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("255")
                }
                .tint(.green)
                Text("Green: \(Int(greenValue))")

                Slider(value: $blueValue, in: 0...255, step: 1) {
                    Text("Blue")
                } minimumValueLabel: {
                    Text("0")
                } maximumValueLabel: {
                    Text("255")
                }
                .tint(.blue)
                Text("Blue: \(Int(blueValue))")
            }
            .padding()
        }
        .padding()
    }
}
