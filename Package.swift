// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PilotKit",
    products: [
        .library(name: "PilotCore", targets: ["PilotCore"])
    ],
    targets: [
        .target(name: "PilotCore", path: "Sources/PilotKit"),
        .testTarget(
            name: "PilotKitTests",
            dependencies: ["PilotCore"],
            path: "Tests/PilotKitTests"
        )
    ]
)
