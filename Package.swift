// swift-tools-version:5.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AC_iOS_NET",
    platforms: [
        .iOS(.v10),
    ],
    products: [
        // Products define the executables and libraries produced by a package, and make them visible to other packages.
        .library(
            name: "AC_iOS_NET",
            targets: ["AC_iOS_NET"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", .upToNextMajor(from: "5.2.0"))
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages which this package depends on.
        .target(
            name: "AC_iOS_NET",
            dependencies: []),
        .testTarget(
            name: "AC_iOS_NETTests",
            dependencies: ["AC_iOS_NET"])
    ],
    swiftLanguageVersions: [.v5]
)
