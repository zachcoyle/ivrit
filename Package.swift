// swift-tools-version: 5.9
import PackageDescription

let package = Package(
  name: "ivrit",
  products: [
    .library(
      name: "ivrit",
      targets: [
        "ivrit"
      ]
    )
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
  ],
  targets: [
    .target(name: "ivrit"),
    .testTarget(
      name: "ivritTests",
      dependencies: [
        "ivrit",
        "SwiftCheck",
        .product(name: "Algorithms", package: "swift-algorithms"),
      ]),
  ]
)
