// swift-tools-version: 6.3
import PackageDescription

let package = Package(
    name: "Molang",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
        .watchOS(.v10),
        .visionOS(.v1)
    ],
    products: [
        .library(name: "Molang", targets: ["Molang"])
    ],
    targets: [
        .target(name: "Molang"),
        .testTarget(name: "MolangTests", dependencies: ["Molang"])
    ]
)
