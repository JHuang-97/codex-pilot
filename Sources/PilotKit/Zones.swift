public enum HeartRateZones {
    public static func karvonenZones(maxHR: Int, restingHR: Int) -> [(zone: Int, lower: Int, upper: Int)] {
        let reserve = Double(maxHR) - Double(restingHR)
        let fractions: [Double] = [0.50, 0.60, 0.70, 0.80, 0.90, 1.00]
        var boundaries = fractions.map {
            Int((Double(restingHR) + $0 * reserve).rounded())
        }
        boundaries[5] = maxHR

        return (0..<5).map {
            (zone: $0 + 1, lower: boundaries[$0], upper: boundaries[$0 + 1])
        }
    }
}
