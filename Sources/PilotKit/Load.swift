public enum LoadMath {
    public static func ewma(_ values: [Double], alpha: Double) -> Double {
        guard let first = values.first else { return 0 }
        return values.dropFirst().reduce(first) { s, x in
            alpha * x + (1 - alpha) * s
        }
    }

    public static func acwr(acute: [Double], chronic: [Double]) -> Double? {
        guard !acute.isEmpty, !chronic.isEmpty else { return nil }
        let acuteMean = acute.reduce(0, +) / Double(acute.count)
        let chronicMean = chronic.reduce(0, +) / Double(chronic.count)
        guard chronicMean != 0 else { return nil }
        return acuteMean / chronicMean
    }

    public static func acwrCategory(_ ratio: Double) -> ACWRCategory {
        if ratio < 0.8 { return .low }
        if ratio <= 1.3 { return .optimal }
        if ratio <= 1.5 { return .caution }
        return .high
    }
}

public enum ACWRCategory: String, Sendable {
    case low = "Low"
    case optimal = "Optimal"
    case caution = "Caution"
    case high = "High"
}
