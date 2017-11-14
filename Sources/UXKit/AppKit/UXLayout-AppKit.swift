//
//  UXKit
//
//  Copyright © 2016-2017 ZeeZide GmbH. All rights reserved.
//
#if os(macOS)
  import Cocoa
  
  public typealias UXLayoutConstraint = NSLayoutConstraint

#if swift(>=4.0)
  public extension NSStackView {
    public typealias Alignment        = NSLayoutConstraint.Attribute
    public typealias UXAlignment      = NSLayoutConstraint.Attribute
    public typealias Axis             = NSUserInterfaceLayoutOrientation
  }
#else // Swift 3.2
  public extension NSLayoutConstraint {
    public typealias Attribute        = NSLayoutAttribute
    public typealias Relation         = NSLayoutRelation
    #if false // crashes 3.2 in Xcode 9 9A235 - Because it exists? in 3.2? But not in 3.1?
      public typealias Priority       = NSLayoutPriority
    #endif
  }
  public extension NSStackView {
    public typealias Distribution     = NSStackViewDistribution
    public typealias Alignment        = NSLayoutAttribute
    public typealias UXAlignment      = NSLayoutAttribute
  }
#endif
  public typealias UXStackViewAxis    = NSUserInterfaceLayoutOrientation
#endif
