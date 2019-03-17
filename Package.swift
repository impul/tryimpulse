// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "tryimpulse",
    products: [
        .library(name: "tryimpulse", targets: ["App"]),
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),

        // 🔵 Swift ORM (queries, models, relations, etc) built on SQLite 3.
        .package(url: "https://github.com/vapor/fluent-sqlite.git", from: "3.0.0"),
        
        .package(url: "https://github.com/impul/BlockObserver.git", from: "0.1.5")
    ],
    targets: [
        .target(name: "App", dependencies: ["FluentSQLite", "Vapor", "BlockObserver"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)

