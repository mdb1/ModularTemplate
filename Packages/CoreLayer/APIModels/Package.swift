// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "APIModels",
    platforms: [.iOS(.v17)],
    products: [
        .library(
            name: "APIModels",
            targets: ["APIModels"]
        ),
    ],
    dependencies: [

    ],
    targets: [
        .target(
            name: "APIModels",
            dependencies: []),
        .testTarget(
            name: "APIModelsTests",
            dependencies: ["APIModels"]
        ),
    ]
)
