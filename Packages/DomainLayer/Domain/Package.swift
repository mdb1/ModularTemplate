// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Domain",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "Domain",
            targets: ["Domain"]),
    ],
    dependencies: [
        .package(path: "../../CoreLayer/APIModels"),
        .package(path: "../../CoreLayer/Logger"),
        .package(path: "../../CoreLayer/Networking"),
        .package(path: "../../CoreLayer/Testing"),
        .package(path: "../../CoreLayer/Utilities"),
    ],
    targets: [
        .target(
            name: "Domain",
            dependencies: [
                "APIModels",
                "Logger",
                "Networking",
                "Utilities",
            ]
        ),
        .testTarget(
            name: "DomainTests",
            dependencies: [
                "Domain",
                "Testing"
            ]
        ),
    ]
)
