// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Kayu",
    platforms: [
        .iOS(.v16),
    ],
    products: [
        .library(name: "Haptics", targets: ["Haptics"]),
        .library(name: "Vibrate", targets: ["Vibrate"])
    ],
    dependencies: [
    ],
    targets: [
        .target(name: "Haptics", dependencies: []),
        .target(name: "Vibrate", dependencies: [])
    ]
)
