// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CygnusReach",
    platforms: [.iOS(.v13)],
    products: [
        .library(
            name: "RemoteSupport",
            targets: ["RemoteSupport"]
        ),
        .library(
            name: "ReachProtocol",
            targets: ["ReachProtocol"]
        ),
        .library(
            name: "CygnusUI",
            targets: ["CygnusUI"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/mxcl/PromiseKit.git", from: "8.0.0"),
        .package(url: "https://github.com/emqx/CocoaMQTT.git", from: "2.1.3"),
        .package(url: "https://github.com/stasel/WebRTC.git", from: "120.0.0"),
        .package(url: "https://github.com/apple/swift-protobuf.git", from: "1.27.0"),
        .package(url: "https://github.com/scalessec/Toast-Swift.git", from: "5.1.1")
    ],
    targets: [
        .binaryTarget(
            name: "RemoteSupport",
            path: "RemoteSupport.xcframework"
        ),
        .target(
            name: "RemoteSupportTargets",
            dependencies: [
                .target(name: "PromiseKit"),
                .target(name: "CocoaMQTT"),
                .target(name: "WebRTC")
            ],
            path: "RemoteSupportTargets"
        ),
        .binaryTarget(
            name: "ReachProtocol",
            path: "ReachProtocol.xcframework"
        ),
        .target(
            name: "ReachProtocolTargets",
            dependencies: [
                .target(name: "SwiftProtobuf")
            ],
            path: "ReachProtocolTargets"
        ),
        .binaryTarget(
            name: "CygnusUI",
            path: "CygnusUI.xcframework"
        ),
        .target(
            name: "CygnusUITargets",
            dependencies: [
                .target(name: "RemoteSupport"),
                .target(name: "ReachProtocol"),
                .target(name: "Toast_Swift")
            ],
            path: "CygnusUITargets"
        )
    ]
)
