//
//  UXAttributedString.swift
//  UXKit
//
//  Created by Helge Hess on 24.10.18.
//  Copyright © 2018 ZeeZide GmbH. All rights reserved.
//

import Foundation

#if swift(>=4.2)
#else
  public extension NSAttributedString {
    public typealias Key = NSAttributedStringKey // new way of doing things
  }
#endif
