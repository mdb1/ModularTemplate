// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Presentation",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Presentation",
            targets: ["Presentation"]),
    ],
    dependencies: [
        .package(path: "../../DomainLayer/Domain"),
        .package(path: "../../CoreLayer/DesignSystem"),
        .package(path: "../../CoreLayer/Testing"),
    ],
    targets: [
        .target(
            name: "Presentation",
            dependencies: ["Domain", "DesignSystem"]),
        .testTarget(
            name: "PresentationTests",
            dependencies: ["Presentation", "Testing"]),
    ]
)
