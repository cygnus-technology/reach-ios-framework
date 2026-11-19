// swift-tools-version: 5.9
import PackageDescription

// Copied alongside the XCFrameworks by build-release.zsh.
let protocolModules = ["ReachProtocol", "SwiftProtobuf"]
let remoteModules = ["RemoteSupport", "ReachWebRTC"]
let sessionModules = ["Session"] + protocolModules + remoteModules

let package = Package(
    name: "CygnusReach",
    platforms: [.iOS("16.6")],
    products: [
        .library(name: "ReachProtocol", targets: protocolModules),
        .library(name: "RemoteSupport", targets: remoteModules),
        .library(name: "Session", targets: sessionModules),
        .library(name: "SessionUI", targets: ["SessionUI"] + sessionModules)
    ],
    dependencies: [
        .package(url: "https://github.com/stasel/WebRTC.git", exact: "147.0.0")
    ],
    targets: ["SwiftProtobuf", "ReachProtocol", "RemoteSupport", "Session", "SessionUI"].map {
        .binaryTarget(name: $0, path: "\($0).xcframework")
    } + [
        .target(name: "ReachWebRTC", dependencies: [.product(name: "WebRTC", package: "WebRTC")])
    ]
)
