// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CircularProgressView",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "CircularProgressView",
            targets: ["CircularProgressView"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "CircularProgressView",
            dependencies: []),
    ]
)
