//
//  UXAttributedString.swift
//  UXKit
//
//  Created by Helge Hess on 24.10.18.
//  Copyright © 2018 ZeeZide GmbH. All rights reserved.
//

import Foundation

// Use: NSAttributedString.Key

#if swift(>=4.2)
  // builtin NSAttributedString.Key
#elseif swift(>=4.0)
  public extension NSAttributedString {
    public typealias Key = NSAttributedStringKey // new way of doing things
  }
#else // < 4.0
  public extension NSAttributedString {
    public typealias Key = String // new way of doing things
  }
#endif
