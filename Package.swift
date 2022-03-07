import PackageDescription

let package = Package(
    name: "UXKit",
    
    platforms: [
        .macOS(.v10_13), .iOS(.v10), .tvOS(.v13)
    ],
    
    exclude: [
        "UXKit.xcodeproj",
        "GNUmakefile",
        "LICENSE",
        "README.md",
        "xcconfig"
    ]
)
