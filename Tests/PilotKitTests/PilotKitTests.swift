import XCTest
@testable import PilotCore

final class PilotKitTests: XCTestCase {
    func testKarvonenZones() {
        let maxHR = 190
        let zones = HeartRateZones.karvonenZones(maxHR: maxHR, restingHR: 60)

        XCTAssertEqual(zones.count, 5)
        XCTAssertEqual(zones.last?.upper, maxHR)
        for zone in zones {
            XCTAssertLessThanOrEqual(zone.lower, zone.upper)
        }
        for (previous, next) in zip(zones, zones.dropFirst()) {
            XCTAssertLessThanOrEqual(previous.lower, next.lower)
            XCTAssertLessThanOrEqual(previous.upper, next.upper)
            XCTAssertEqual(previous.upper, next.lower)
        }
    }

    func testEWMA() {
        XCTAssertEqual(LoadMath.ewma([10, 20], alpha: 0.5), 15)
        XCTAssertEqual(LoadMath.ewma([], alpha: 0.3), 0)
    }

    func testACWR() {
        XCTAssertEqual(LoadMath.acwr(acute: [100, 100], chronic: [50, 50]), 2.0)
        XCTAssertNil(LoadMath.acwr(acute: [100, 100], chronic: []))
    }
}
