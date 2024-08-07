// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CygnusReach",
    platforms: [.iOS(.v13)],
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
            name: "CygnusUI",
            targets: ["CygnusUITarget"]
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
            name: "RemoteSupportTarget",
            dependencies: [
                "PromiseKit",
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
                .product(name: "SwiftProtobuf", package: "swift-protobuf")
            ],
            path: "ReachProtocolWrap"
        ),
        .binaryTarget(
            name: "CygnusUI",
            path: "CygnusUI.xcframework"
        ),
        .target(
            name: "CygnusUITarget",
            dependencies: [
                .target(name: "RemoteSupport"),
                .target(name: "ReachProtocol"),
                "Toast-Swift"
            ],
            path: "CygnusUIWrap"
        )
    ]
)
