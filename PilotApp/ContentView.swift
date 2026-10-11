import SwiftUI
import PilotCore

struct ContentView: View {
    @State private var maxHR = 190
    @State private var restingHR = 55

    private let acuteLoads: [Double] = [42, 55, 48, 60, 52, 58, 50]
    private let chronicLoads: [Double] = [40, 42, 38, 45, 41, 39, 44]

    var body: some View {
        NavigationStack {
            List {
                Section("Heart rate") {
                    Stepper("Max HR: \(maxHR)", value: $maxHR, in: 120...220)
                    Stepper("Resting HR: \(restingHR)", value: $restingHR, in: 35...100)
                }

                Section("Zones") {
                    let zones = HeartRateZones.karvonenZones(
                        maxHR: maxHR,
                        restingHR: restingHR
                    )
                    ForEach(Array(zones.enumerated()), id: \.offset) { index, zone in
                        LabeledContent("Zone \(index + 1)") {
                            Text("\(zone.lower)–\(zone.upper) bpm")
                        }
                    }
                }

                Section("Training load") {
                    LabeledContent("7-day EWMA load") {
                        Text(LoadMath.ewma(acuteLoads, alpha: 0.25), format: .number.precision(.fractionLength(2)))
                    }
                    LabeledContent("ACWR") {
                        if let ratio = LoadMath.acwr(acute: acuteLoads, chronic: chronicLoads) {
                            Text("\(String(format: "%.2f", ratio)) · \(LoadMath.acwrCategory(ratio).rawValue)")
                        } else {
                            Text("Unavailable")
                        }
                    }
                }
            }
            .navigationTitle("PilotKit")
        }
    }
}
