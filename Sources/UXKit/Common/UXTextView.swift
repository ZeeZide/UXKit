//
//  UXTextView.swift
//  UXKit
//
//  Created by Helge Heß on 16.05.20.
//  Copyright © 2020-2021 ZeeZide GmbH. All rights reserved.
//

#if !os(macOS)
  import class  UIKit.NSTextStorage
  import class  UIKit.NSLayoutManager
  import class  UIKit.NSTextContainer
  import struct UIKit.NSTextStorageEditActions

  public typealias NSTextStorage   = UIKit.NSTextStorage
  public typealias NSLayoutManager = UIKit.NSLayoutManager
  public typealias NSTextContainer = UIKit.NSTextContainer

  public typealias NSTextStorageEditActions = UIKit.NSTextStorage.EditActions
#else // macOS
  import class  AppKit.NSTextStorage
  import class  AppKit.NSLayoutManager
  import class  AppKit.NSTextContainer
  import struct AppKit.NSTextStorageEditActions

  public typealias NSTextStorage   = AppKit.NSTextStorage
  public typealias NSLayoutManager = AppKit.NSLayoutManager
  public typealias NSTextContainer = AppKit.NSTextContainer

  public typealias NSTextStorageEditActions = AppKit.NSTextStorageEditActions
  public extension NSTextStorage {
    typealias EditActions = NSTextStorageEditActions
  }
#endif // macOS
