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
  import class UIKit.NSStringDrawingContext

  public typealias NSTextStorage   = UIKit.NSTextStorage
  public typealias NSLayoutManager = UIKit.NSLayoutManager
  public typealias NSTextContainer = UIKit.NSTextContainer
  public typealias NSTextAlignment = UIKit.NSTextAlignment
  public typealias NSMutableParagraphStyle = UIKit.NSMutableParagraphStyle
  public typealias NSStringDrawingContext = UIKit.NSStringDrawingContext
#else // macOS
  import class AppKit.NSTextStorage
  import class AppKit.NSLayoutManager
  import class AppKit.NSTextContainer
  import enum AppKit.NSTextAlignment
  import class AppKit.NSMutableParagraphStyle
  import class AppKit.NSStringDrawingContext

  public typealias NSTextStorage   = AppKit.NSTextStorage
  public typealias NSLayoutManager = AppKit.NSLayoutManager
  public typealias NSTextContainer = AppKit.NSTextContainer
  public typealias NSTextAlignment = AppKit.NSTextAlignment
  public typealias NSMutableParagraphStyle = AppKit.NSMutableParagraphStyle
  public typealias NSStringDrawingContext = AppKit.NSStringDrawingContext
#endif // macOS
