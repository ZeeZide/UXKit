//
//  UXKit
//
//  Copyright © 2016-2017 ZeeZide GmbH. All rights reserved.
//

import Foundation

/**
 * A common protocol for "view controllers". Note that this itself is
 * unfortunately NOT a view controller (because a protocol can't be restricted
 * to a class).
 * But you can piggy back to the real thing using the `uxViewController`
 * property.
 *
 * The `UXViewController` alias either directly maps to `NSViewController` or
 * `UIViewController`.
 */
@objc public protocol UXViewControllerType
                      : UXObjectPresentingType,
                        UXUserInterfaceItemIdentification
{
  // Too bad that we can't adopt NSViewController as a protocol.
  
  // MARK: - Getting the actual VC
  
  var uxViewController : UXViewController { get }
  
  // MARK: - The View
  
  /// Note: `view` is `UXView` on macOS and `UXView!` on iOS
  var rootView : UXView { get }
  
  // MARK: - View Controllers
  
  func uxAddChild(_ childViewController: UXViewController)
  func uxRemoveFromParent()
  var  uxChildren : [ UXViewController ] { get }
}

#if os(macOS)
  import Cocoa

  public typealias UXViewController = NSViewController
#else // iOS
  import UIKit
  
  fileprivate var uivcID : UInt8 = 42

  public typealias UXViewController = UIViewController

  extension UIViewController : UXUserInterfaceItemIdentification {
    
    /// Add `identifier` to UIViewController
    @objc open var identifier : UXUserInterfaceItemIdentifier? {
      set {
        objc_setAssociatedObject(self, &uivcID, newValue,
                                 objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN)
      }
      get {
        return objc_getAssociatedObject(self, &uivcID) as? String
      }
    }
  }
#endif // end: iOS

extension UXViewController : UXViewControllerType {
  
  public var uxViewController : UXViewController { return self }
  public var rootView         : UXView           { return view }

  // Note: The ux prefixes are necessary due to Swift compiler madness where
  //       it gets confused what uses selectors in #ifs and when and how. Sigh.
  
  #if swift(>=4.2)
    public func uxAddChild(_ vc: UXViewController) { addChild(vc) }
    public var  uxChildren : [ UXViewController ]  { return children }
    public func uxRemoveFromParent() { removeFromParent() }
  #else
    public func uxAddChild(_ vc: UXViewController) {
      addChildViewController(vc)
    }
    public var uxChildren : [ UXViewController ] {
      return childViewControllers
    }
    public func uxRemoveFromParent() { removeFromParentViewController() }
  #endif
}
