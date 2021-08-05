//
//  UXKit
//
//  Copyright © 2016-2019 ZeeZide GmbH. All rights reserved.
//
#if os(macOS)
  import Cocoa
  
  public typealias UXFloat            = CGFloat
  
  public typealias UXColor            = NSColor
  
  public typealias UXBezierPath       = NSBezierPath
  public typealias UXRect             = NSRect
  public typealias UXPoint            = NSPoint
  public typealias UXSize             = NSSize
  public let       UXEdgeInsetsMake   = NSEdgeInsetsMake

  public typealias UXImage            = NSImage

  #if swift(>=4.0)
    public typealias UXEdgeInsets     = NSEdgeInsets
  #else
    public typealias UXEdgeInsets     = EdgeInsets
  #endif

  public extension CGColor {
    
    // macOS has no CGColor(gray:alpha:)
    static func new(gray: CGFloat, alpha: CGFloat) -> CGColor {
      return CGColor(gray: gray, alpha: alpha)
    }
    
  }
  
  public extension NSRect {
    
    func inset(by insets: NSEdgeInsets) -> NSRect {
      var newRect = self
      newRect.origin.x    += insets.left
      newRect.origin.y    += insets.bottom
      newRect.size.width  -= (insets.left + insets.right)
      newRect.size.height -= (insets.top  + insets.bottom)
      return newRect
    }
  }

  public extension UXImage {
    
    static var applicationIconImage: UXImage? {
      return UXImage(named: NSImage.applicationIconName)
    }
    
    static func image(withSize size: CGSize, andContent drawContent: () -> Void) -> UXImage {
        let textImage = NSImage(size: size)
        if let rep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: Int(size.width), pixelsHigh: Int(size.height), bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: .calibratedRGB, bytesPerRow: 0, bitsPerPixel: 0) {
            textImage.addRepresentation(rep)
            NSGraphicsContext.saveGraphicsState()
            NSGraphicsContext.current = NSGraphicsContext.init(bitmapImageRep: rep)
        }
        
        drawContent()
        
        NSGraphicsContext.restoreGraphicsState()
            
        return textImage
    }
  }
#endif // os(macOS)
