//
//  UXKit
//
//  Copyright © 2016-2017 ZeeZide GmbH. All rights reserved.
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
    public func UXEdgeInsetsMake(_ top: CGFloat, _ left: CGFloat,
                                 _ bottom: CGFloat, _ right: CGFloat)
                -> UXEdgeInsets
    {
      return UXEdgeInsets(top: top, left: left, bottom: bottom, right: right)
    }
  #else
    public let       UXEdgeInsetsMake   = UIEdgeInsetsMake
  #endif
  
  public extension CGColor {
    
    // iOS has no CGColor(gray:alpha:)
    public static func new(gray: CGFloat, alpha: CGFloat) -> CGColor {
      return UIColor(red: gray, green: gray, blue: gray, alpha: alpha).cgColor
    }
    
  }
#endif
