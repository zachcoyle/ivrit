// swift-tools-version: 5.9
import PackageDescription

let package = Package(
  name: "IvritKit",
  products: [
    .library(
      name: "IvritKit",
      targets: [
        "IvritKit"
      ]
    ),
    .executable(
      name: "ivrit",
      targets: [
        "ivrit"
      ]
    ),
  ],
  dependencies: [
    .package(
      url: "https://github.com/typelift/SwiftCheck.git",
      exact: "0.12.0"
    ),
    .package(
      url: "https://github.com/apple/swift-algorithms.git",
      revision: "c3b3acbca3aa70adbd30756fe137b14e25140c0d"
    ),
    .package(
      url: "https://github.com/apple/swift-argument-parser",
      exact: "1.3.0"
    ),
  ],
  targets: [
    .executableTarget(
      name: "ivrit",
      dependencies: [
        "IvritKit",
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
      ]),
    .target(name: "IvritKit"),
    .testTarget(
      name: "ivritTests",
      dependencies: [
        "IvritKit",
        "SwiftCheck",
        .product(name: "Algorithms", package: "swift-algorithms"),
      ]),
  ]
)
