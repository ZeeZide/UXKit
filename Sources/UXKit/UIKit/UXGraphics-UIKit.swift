//
//  UXKit
//
//  Copyright © 2016-2019 ZeeZide GmbH. All rights reserved.
//
#if !os(macOS)
  import UIKit
  
  public typealias UXFloat            = CGFloat

  public typealias UXColor            = UIColor

  public typealias UXBezierPath       = UIBezierPath
  public typealias UXRect             = CGRect
  public typealias UXPoint            = CGPoint
  public typealias UXSize             = CGSize

  public typealias UXImage            = UIImage
  
  public typealias UXEdgeInsets       = UIEdgeInsets

  #if swift(>=4.2)
    @inlinable
    public func UXEdgeInsetsMake(_ top    : CGFloat, _ left  : CGFloat,
                                 _ bottom : CGFloat, _ right : CGFloat)
                -> UXEdgeInsets
    {
      return UXEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
  #else
    public let  UXEdgeInsetsMake = UIEdgeInsetsMake
  #endif
  
  public extension CGColor {
    
    // iOS has no CGColor(gray:alpha:)
    static func new(gray: CGFloat, alpha: CGFloat) -> CGColor {
      return UIColor(red: gray, green: gray, blue: gray, alpha: alpha).cgColor
    }
  }

  public extension UXImage {
    
    typealias Name = String // use on older macOS bindings
    
    static var applicationIconImage: UXImage? {
      guard let icon = (Bundle.main.infoDictionary?["CFBundleIconFiles"]
                       as? [ String ])?.first else { return nil }
      return UXImage(named: icon)
    }
  }
#endif // !os(macOS)
