// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "MoLang",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17),
        .macOS(.v14),
        .tvOS(.v17),
        .watchOS(.v10),
        .visionOS(.v1)
    ],
    products: [
        .library(name: "MoLang", targets: ["MoLang"])
    ],
    targets: [
        .target(name: "MoLang")
    ]
)
