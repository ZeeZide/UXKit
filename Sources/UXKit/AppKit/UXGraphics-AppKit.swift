//
//  UXKit
//
//  Copyright © 2016-2022 ZeeZide GmbH. All rights reserved.
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
  public typealias UXEvent            = NSEvent
  public typealias UXTouch            = NSTouch

  #if swift(>=4.0)
    public typealias UXEdgeInsets     = NSEdgeInsets
  #else
    public typealias UXEdgeInsets     = EdgeInsets
  #endif

  public extension UXColor {
  
    // iOS compat
    @inlinable
    static var link            : UXColor { return .linkColor            }
    @inlinable
    static var label           : UXColor { return .labelColor           }
    @inlinable
    static var secondaryLabel  : UXColor { return .secondaryLabelColor  }
    @inlinable
    static var tertiaryLabel   : UXColor { return .tertiaryLabelColor   }
    @inlinable
    static var quaternaryLabel : UXColor { return .quaternaryLabelColor }
  }

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
    
    /// Returns an image of the specified size, allowing the caller to provide a draw function that draws into the "current" graphics context.
    /// - Parameters:
    ///   - size: The size of the image
    ///   - drawContent: A block responsible for drawing into the image.
    /// - Returns: The image (which may be blank).
    static func image(withSize size: CGSize, andContent drawContent: () -> Void) -> UXImage {
        let resultImage = NSImage(size: size)
        if let rep = NSBitmapImageRep(bitmapDataPlanes: nil, pixelsWide: Int(size.width), pixelsHigh: Int(size.height), bitsPerSample: 8, samplesPerPixel: 4, hasAlpha: true, isPlanar: false, colorSpaceName: .calibratedRGB, bytesPerRow: 0, bitsPerPixel: 0) {
            resultImage.addRepresentation(rep)
            NSGraphicsContext.saveGraphicsState()
            NSGraphicsContext.current = NSGraphicsContext(bitmapImageRep: rep)
            
            drawContent()
            
            NSGraphicsContext.restoreGraphicsState()
        }
            
        return resultImage
    }
  }

import class SpriteKit.SKScene

public extension UXTouch {
    
    func location(inScene: SKScene) -> UXPoint {
        return self.location(in: inScene.view)
    }
}

public extension NSBezierPath {
    
    /// CREDIT:  https://gist.github.com/juliensagot/9749c3a1df28c38fb9f9
    /// A `CGPath` object representing the current `NSBezierPath`.
    var cgPath: CGPath {
        let path = CGMutablePath()
        let points = UnsafeMutablePointer<NSPoint>.allocate(capacity: 3)

        if elementCount > 0 {
            for index in 0..<elementCount {
                let pathType = element(at: index, associatedPoints: points)

                switch pathType {
                case .moveTo:
                    path.move(to: points[0])
                case .lineTo:
                    path.addLine(to: points[0])
                case .curveTo:
                    path.addCurve(to: points[2], control1: points[0], control2: points[1])
                case .closePath:
                    path.closeSubpath()
                    case .cubicCurveTo:
                        path.addCurve(to: points[2], control1: points[0], control2: points[1])
                        
                    case .quadraticCurveTo:
                        path.addCurve(to: points[2], control1: points[0], control2: points[1])
                @unknown default:
                    break
                }
            }
        }

        points.deallocate()
        return path
    }
    
    func apply(_ transform: CGAffineTransform) {
        let macTransform = AffineTransform(m11: transform.a, m12: transform.b, m21: transform.c, m22: transform.d, tX: transform.tx, tY: transform.ty)
        self.transform(using: macTransform)
    }
}
#endif // os(macOS)
