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
  public let       UXEdgeInsetsMake   = UIEdgeInsetsMake
  
  public typealias UXImage            = UIImage
  
  public typealias UXEdgeInsets       = UIEdgeInsets

  public extension CGColor {
    
    // iOS has no CGColor(gray:alpha:)
    public static func new(gray: CGFloat, alpha: CGFloat) -> CGColor {
      return UIColor(red: gray, green: gray, blue: gray, alpha: alpha).cgColor
    }
    
  }
#endif
