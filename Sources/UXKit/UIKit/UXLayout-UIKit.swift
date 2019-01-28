//
//  UXKit
//
//  Copyright © 2016-2019 ZeeZide GmbH. All rights reserved.
//
#if !os(macOS)
  import UIKit

  public typealias UXLayoutConstraint = NSLayoutConstraint

  #if swift(>=4.2)
    public extension UIStackView {
      typealias UXAlignment      = NSLayoutConstraint.Attribute
    }
    public extension NSLayoutConstraint {
      typealias Priority         = UILayoutPriority
    }

    public typealias UXStackViewAxis    = NSLayoutConstraint.Axis
  #else
    public extension NSLayoutConstraint {
      public typealias Attribute        = NSLayoutAttribute
      public typealias Relation         = NSLayoutRelation
      public typealias Priority         = UILayoutPriority
      public typealias Axis             = UILayoutConstraintAxis
    }
    
    public extension UIStackView {
      public typealias Distribution     = UIStackViewDistribution
      public typealias Alignment        = UIStackViewAlignment
                                        // an NSLayoutAttribute on macOS
      public typealias UXAlignment      = NSLayoutAttribute
    }

    public typealias UXStackViewAxis    = UILayoutConstraintAxis
  #endif
#endif
