import PackageDescription

let package = Package(
  name: "UXKit",
  platforms: [
    .macOS(.v10_12), .iOS(.v10)
  ],
  products: [
    .library(name: "UXKit", targets: ["UXKit"]),
  ],
  targets: [
    .target(name:"UXKit")
  ]
)
