// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftyReplica",
    platforms: [
        .macOS(.v10_12), .iOS(.v9), .tvOS(.v9)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SwiftyReplica",
            targets: ["SwiftyReplica"]
        ),
        .executable(
            name: "SwiftyReplicaRun",
            targets: ["SwiftyReplicaRun"]
        )
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        .package(url: "https://github.com/GroupeMINASTE/SwiftMC", branch: "master")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SwiftyReplica",
            dependencies: ["SwiftMC"]
        ),
        .executableTarget(
            name: "SwiftyReplicaRun",
            dependencies: ["SwiftyReplica"]
        ),
        .testTarget(
            name: "SwiftyReplicaTests",
            dependencies: ["SwiftyReplica"]
        ),
    ]
)
