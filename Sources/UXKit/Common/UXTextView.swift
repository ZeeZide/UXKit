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
  import enum UIKit.NSTextAlignment
  import class UIKit.NSMutableParagraphStyle

  public typealias NSTextStorage   = UIKit.NSTextStorage
  public typealias NSLayoutManager = UIKit.NSLayoutManager
  public typealias NSTextContainer = UIKit.NSTextContainer
  public typealias NSTextAlignment = UIKit.NSTextAlignment
  public typealias NSMutableParagraphStyle = UIKit.NSMutableParagraphStyle
#else // macOS
  import class AppKit.NSTextStorage
  import class AppKit.NSLayoutManager
  import class AppKit.NSTextContainer
  import enum AppKit.NSTextAlignment
  import class AppKit.NSMutableParagraphStyle

  public typealias NSTextStorage   = AppKit.NSTextStorage
  public typealias NSLayoutManager = AppKit.NSLayoutManager
  public typealias NSTextContainer = AppKit.NSTextContainer
  public typealias NSTextAlignment = AppKit.NSTextAlignment
  public typealias NSMutableParagraphStyle = AppKit.NSMutableParagraphStyle
#endif // macOS
