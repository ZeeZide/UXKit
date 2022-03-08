import PackageDescription

let package = Package(
    name: "UXKit",
    
    platforms: [
        .macOS(.v10_13), .iOS(.v12), .tvOS(.v12)
    ],
    
    exclude: [
        "UXKit.xcodeproj",
        "GNUmakefile",
        "LICENSE",
        "README.md",
        "xcconfig"
    ]
)
