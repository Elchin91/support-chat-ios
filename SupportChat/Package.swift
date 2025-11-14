// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SupportChat",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .executable(name: "SupportChat", targets: ["SupportChat"])
    ],
    dependencies: [
        // Network layer
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.8.0"),
        // WebSocket support
        .package(url: "https://github.com/socketio/socket.io-client-swift", from: "16.1.0"),
        // JSON parsing
        .package(url: "https://github.com/SwiftyJSON/SwiftyJSON.git", from: "5.0.1")
    ],
    targets: [
        .executableTarget(
            name: "SupportChat",
            dependencies: [
                "Alamofire",
                .product(name: "SocketIO", package: "socket.io-client-swift"),
                "SwiftyJSON"
            ],
            path: "Sources"
        )
    ]
)
