//
//  UXTextView.swift
//  UXKit
//
//  Created by Helge Heß on 16.05.20.
//  Copyright © 2020 ZeeZide GmbH. All rights reserved.
//

#if !os(macOS)
  import class UIKit.NSTextStorage
  import class UIKit.NSLayoutManager
  import class UIKit.NSTextContainer

  public typealias NSTextStorage   = UIKit.NSTextStorage
  public typealias NSLayoutManager = UIKit.NSLayoutManager
  public typealias NSTextContainer = UIKit.NSTextContainer
#else // macOS
  import class AppKit.NSTextStorage
  import class AppKit.NSLayoutManager
  import class AppKit.NSTextContainer

  public typealias NSTextStorage   = AppKit.NSTextStorage
  public typealias NSLayoutManager = AppKit.NSLayoutManager
  public typealias NSTextContainer = AppKit.NSTextContainer
#endif // macOS
