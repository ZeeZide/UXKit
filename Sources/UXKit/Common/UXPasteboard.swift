//
//  UXKit
//
//  Copyright © 2016-2019 ZeeZide GmbH. All rights reserved.
//
#if os(macOS)
  import class Cocoa.NSPasteboard
  
  public typealias UXPasteboard = NSPasteboard
  
  public extension NSPasteboard {
    
    enum ux {
      /**
       * Only necessary for Swift 3 AppKit. Swift 4 AppKit and UIKit both
       * provide a `general` property (so you can just use
       * `UXPasteboard.shared`).
       * If you want to support Swift 3, use: `UXPasteboard.ux.shared` instead.
       */
      public static var general : UXPasteboard {
        #if swift(>=4.0)
          return NSPasteboard.general
        #else
          return NSPasteboard.general()
        #endif
      }
    }
  }
#else // !os(macOS)
  import class UIKit.UIPasteboard
  
  public typealias UXPasteboard = UIPasteboard
  
  public extension UIPasteboard {
    
    typealias PasteboardType = String
    
    enum ux {
      /**
       * Only necessary for Swift 3 AppKit. Swift 4 AppKit and UIKit both
       * provide a `general` property (so you can just use
       * `UXPasteboard.shared`).
       * If you want to support Swift 3, use: `UXPasteboard.ux.shared` instead.
       */
      public static var general : UXPasteboard {
        return UIPasteboard.general
      }
    }
    
    /**
     * Before you can provide new content to the pasteboard on AppKit, you need
     * to clear it.
     * Not quite sure why this doesn't exist on iOS? Are we supposed to reset
     * specific pasteboards?
     */
    @discardableResult
    func clearContents() -> Int {
      return changeCount
    }
  }
#endif // !os(macOS)
