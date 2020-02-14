// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "XcodeBuildTimingsToCSV",
    products: [
        .executable(name: "xcode_build_timings2csv", targets: ["XcodeBuildTimingsToCSVMain"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
        .package(url: "https://github.com/kylef/Commander.git", from: "0.8.0"),
        .package(url: "https://github.com/Quick/Nimble", from: "7.1.0"),
        .package(url: "https://github.com/Quick/Quick", from: "1.3.0"),
        .package(url: "https://github.com/kareman/FootlessParser", from: "0.5.0"),
        .package(url: "https://github.com/onevcat/Rainbow", from: "3.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "XcodeBuildTimingsToCSV",
            dependencies: ["FootlessParser"]),
        .target(
            name: "XcodeBuildTimingsToCSVMain",
            dependencies: ["XcodeBuildTimingsToCSV", "Rainbow", "Commander"]),
        .testTarget(
            name: "XcodeBuildTimingsToCSVTest",
            dependencies: ["XcodeBuildTimingsToCSV", "Quick", "Nimble"]),
    ]
)
