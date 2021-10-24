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
  import class  UIKit.UITextView

  public typealias NSTextStorage   = UIKit.NSTextStorage
  public typealias NSLayoutManager = UIKit.NSLayoutManager
  public typealias NSTextContainer = UIKit.NSTextContainer

  public typealias NSTextStorageEditActions = UIKit.NSTextStorage.EditActions

  public extension UITextView {
    
    @inlinable
    var string : String { // NeXTstep was right!
      set { text = newValue}
      get { return text }
    }
  }
#else // macOS
  import class  AppKit.NSTextStorage
  import class  AppKit.NSLayoutManager
  import class  AppKit.NSTextContainer
  import struct AppKit.NSTextStorageEditActions

  public typealias NSTextStorage   = AppKit.NSTextStorage
  public typealias NSLayoutManager = AppKit.NSLayoutManager
  public typealias NSTextContainer = AppKit.NSTextContainer

  @available(macOS 10.11, *)
  public typealias NSTextStorageEditActions = AppKit.NSTextStorageEditActions
  
  @available(macOS 10.11, *)
  public extension NSTextStorage {
    typealias EditActions = NSTextStorageEditActions
  }
#endif // macOS
