import SwiftUI

struct TipCalculatorView: View {
    @State private var billAmountString: String = ""
    @State private var tipPercentage: Double = 18.0

    private var billAmount: Double {
        return Double(billAmountString) ?? 0
    }

    private var tipAmount: Double {
        return billAmount * (tipPercentage / 100)
    }

    private var totalAmount: Double {
        return billAmount + tipAmount
    }

    var body: some View {
        VStack(spacing: 20) {
            TextField("Enter bill amount", text: $billAmountString)
                .keyboardType(.decimalPad)
                .textFieldStyle(.roundedBorder)
                .padding()

            HStack {
                Text("Tip Percentage:")
                Picker("Tip Percentage", selection: $tipPercentage) {
                    Text("15%").tag(15.0)
                    Text("18%").tag(18.0)
                    Text("20%").tag(20.0)
                }
                .pickerStyle(.segmented)
            }
            .padding()

            VStack(alignment: .leading, spacing: 10) {
                Text("Bill Amount: \(billAmount, specifier: "%.2f")")
                Text("Tip Amount: \(tipAmount, specifier: "%.2f")")
                Text("Total Amount: \(totalAmount, specifier: "%.2f")")
                    .fontWeight(.bold)
            }
            .font(.title2)
        }
        .padding()
    }
}
