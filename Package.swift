// swift-tools-version: 6.0
import PackageDescription

let package = Package(
    name: "GhosttyKit",
    platforms: [
        .iOS(.v16),
        .macOS(.v13),
        .macCatalyst(.v16),
    ],
    products: [
        .library(name: "GhosttyKit", targets: ["GhosttyKit"]),
        .library(name: "GhosttyTerminal", targets: ["GhosttyTerminal"]),
        .library(name: "ShellCraftKit", targets: ["ShellCraftKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Lakr233/MSDisplayLink.git", from: "2.1.0"),
    ],
    targets: [
        .target(
            name: "GhosttyKit",
            dependencies: ["libghostty"],
            path: "Sources/GhosttyKit",
            linkerSettings: [
                .linkedLibrary("c++"),
                .linkedFramework("Carbon", .when(platforms: [.macOS])),
            ]
        ),
        .target(
            name: "GhosttyTerminal",
            dependencies: ["GhosttyKit", "MSDisplayLink"],
            path: "Sources/GhosttyTerminal"
        ),
        .target(
            name: "ShellCraftKit",
            dependencies: ["GhosttyTerminal"],
            path: "Sources/ShellCraftKit"
        ),
        .binaryTarget(
            name: "libghostty",
            url: "https://github.com/linhay/libghostty-spm-main/releases/download/storage.1.0.1783336095/GhosttyKit.xcframework.zip",
            checksum: "468a46735fd559510a92231bb22723cd4b13966a0d3a9c9ec157e748f4f888d7"
        ),
        .testTarget(
            name: "GhosttyKitTest",
            dependencies: ["GhosttyKit", "GhosttyTerminal", "ShellCraftKit"]
        ),
    ]
)
