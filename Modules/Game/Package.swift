// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Game",
    platforms: [.iOS("15.5")],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "Game",
            targets: ["Game"])
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/ReactiveX/RxSwift.git", from: "6.5.0"),
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.4.1"),
        .package(url: "https://github.com/argahutama/GameCatalogCorePackage.git", from: "1.0.0")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "Game",
            dependencies: [
                .product(name: "RxSwift", package: "RxSwift"),
                .product(name: "Kingfisher", package: "Kingfisher"),
                .product(name: "CorePackage", package: "GameCatalogCorePackage")
            ]
        ),
        .testTarget(
            name: "GameTests",
            dependencies: ["Game"])
    ]
)
