// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "PilotKit",
    products: [
        .library(name: "PilotKit", targets: ["PilotKit"])
    ],
    targets: [
        .target(name: "PilotKit"),
        .testTarget(name: "PilotKitTests", dependencies: ["PilotKit"])
    ]
)
