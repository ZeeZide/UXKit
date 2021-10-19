//
//  UXKit
//
//  Copyright © 2016-2021 ZeeZide GmbH. All rights reserved.
//
#if !os(macOS)
  import UIKit
  
  public typealias UXFont           = UIFont
  public typealias NSUnderlineStyle = UIKit.NSUnderlineStyle

  public extension UXFont {
    
    /**
     * macOS compat. Only works on iOS 13+ (otherwise returns nil).
     *
     * Calls into `UIFont.monospacedSystemFont()`.
     */
    static func userFixedPitchFont(ofSize size: CGFloat) -> UXFont? {
      if #available(iOS 13.0, *) {
        return UIFont.monospacedSystemFont(ofSize: size, weight: .regular)
      }
      else {
        return nil
      }
    }
  }
#endif // !os(macOS)
