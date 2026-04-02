// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CygnusReach",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "RemoteSupport",
            targets: ["RemoteSupportTarget"]
        ),
        .library(
            name: "ReachProtocol",
            targets: ["ReachProtocolTarget"]
        ),
        .library(
            name: "Session",
            targets: ["SessionTarget"]
        ),
        .library(
            name: "SessionUI",
            targets: ["SessionUITarget"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/emqx/CocoaMQTT.git", from: "2.1.3"),
        .package(url: "https://github.com/stasel/WebRTC.git", from: "120.0.0"),
        .package(url: "https://github.com/apple/swift-protobuf.git", exact: "1.27.1")
    ],
    targets: [
        .binaryTarget(
            name: "RemoteSupport",
            path: "RemoteSupport.xcframework"
        ),
        .target(
            name: "RemoteSupportTarget",
            dependencies: [
                .target(name: "RemoteSupport"),
                "CocoaMQTT",
                "WebRTC"
            ],
            path: "RemoteSupportWrap"
        ),
        .binaryTarget(
            name: "ReachProtocol",
            path: "ReachProtocol.xcframework"
        ),
        .target(
            name: "ReachProtocolTarget",
            dependencies: [
                .target(name: "ReachProtocol"),
                .product(name: "SwiftProtobuf", package: "swift-protobuf")
            ],
            path: "ReachProtocolWrap"
        ),
        .binaryTarget(
            name: "Session",
            path: "Session.xcframework"
        ),
        .target(
            name: "SessionTarget",
            dependencies: [
                .target(name: "RemoteSupportTarget"),
                .target(name: "ReachProtocolTarget"),
                .target(name: "Session")
            ],
            path: "SessionWrap"
        ),
        .binaryTarget(
            name: "SessionUI",
            path: "SessionUI.xcframework"
        ),
        .target(
            name: "SessionUITarget",
            dependencies: [
                .target(name: "SessionTarget"),
                .target(name: "SessionUI")
            ],
            path: "SessionUIWrap"
        )
    ]
)
