//
//  UXKit
//
//  Copyright © 2016-2023 ZeeZide GmbH. All rights reserved.
//
#if os(macOS)
  import Cocoa
  
  public typealias UXLayoutConstraint = NSLayoutConstraint
  
  @available(OSX 10.11, *)
  public typealias UXLayoutGuide      = NSLayoutGuide

  public extension NSStackView {
    typealias Alignment               = NSLayoutConstraint.Attribute
    typealias UXAlignment             = NSLayoutConstraint.Attribute
    typealias Axis                    = NSUserInterfaceLayoutOrientation
  }
  public typealias UXStackViewAxis    = NSUserInterfaceLayoutOrientation
#endif
