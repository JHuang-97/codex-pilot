import XCTest
@testable import PilotCore

/// Acceptance tests written by the orchestrator (Muse), independent of the
/// implementer's own tests. Expected values computed by hand from the spec.
final class AcceptanceTests: XCTestCase {
    func testZonesExactValues() {
        // maxHR 190, resting 55, reserve 135:
        // bounds at .5/.6/.7/.8/.9/1.0 = 123/136/150/163/177/190 (half away from zero)
        let zones = HeartRateZones.karvonenZones(maxHR: 190, restingHR: 55)
        let rendered = zones.map { "\($0.zone):\($0.lower)-\($0.upper)" }
        XCTAssertEqual(rendered, ["1:123-136", "2:136-150", "3:150-163", "4:163-177", "5:177-190"])
    }

    func testEWMAExtra() {
        XCTAssertEqual(LoadMath.ewma([42], alpha: 0.9), 42)
        XCTAssertEqual(LoadMath.ewma([0, 10, 10], alpha: 0.5), 7.5)
    }

    func testACWRExtra() {
        XCTAssertNil(LoadMath.acwr(acute: [], chronic: [1]))
        XCTAssertNil(LoadMath.acwr(acute: [10], chronic: [0, 0]))
        XCTAssertEqual(LoadMath.acwr(acute: [30], chronic: [10, 20]), 2.0)
    }
}
