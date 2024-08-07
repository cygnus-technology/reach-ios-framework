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
            name: "RemoteSupportFramework",
            path: "RemoteSupport.xcframework"
        ),
        .target(
            name: "RemoteSupport",
            dependencies: [
                .target(name: "RemoteSupportFramework"),
                "PromiseKit",
                "CocoaMQTT",
                "WebRTC"
            ],
            path: "RemoteSupportWrap"
        ),
        .binaryTarget(
            name: "ReachProtocolFramework",
            path: "ReachProtocol.xcframework"
        ),
        .target(
            name: "ReachProtocol",
            dependencies: [
                .target(name: "ReachProtocolFramework"),
                .product(name: "SwiftProtobuf", package: "swift-protobuf")
            ],
            path: "ReachProtocolWrap"
        ),
        .binaryTarget(
            name: "CygnusUIFramework",
            path: "CygnusUI.xcframework"
        ),
        .target(
            name: "CygnusUI",
            dependencies: [
                .target(name: "RemoteSupportFramework"),
                .target(name: "ReachProtocolFramework"),
                .target(name: "CygnusUIFramework"),
                .product(name: "Toast", package: "Toast-Swift")
            ],
            path: "CygnusUIWrap"
        )
    ]
)
