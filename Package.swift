import PackageDescription

let package = Package(
    name: "UXKit",
    
    platforms: [
        .macOS(.v10_15), .iOS(.v13), .tvOS(.v13)
    ],
    
    exclude: [
        "UXKit.xcodeproj",
        "GNUmakefile",
        "LICENSE",
        "README.md",
        "xcconfig"
    ]
)
