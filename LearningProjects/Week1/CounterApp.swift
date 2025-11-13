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
