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
  
  func addChildViewController(_ childViewController: UXViewController)
  var childViewControllers : [ UXViewController ] { get }
}

#if os(macOS)
  import Cocoa

  public typealias UXViewController = NSViewController
  
  extension NSViewController : UXViewControllerType {
    public var uxViewController : UXViewController { return self }
    public var rootView         : UXView           { return view }
  }
  
#else // iOS
  import UIKit
  
  fileprivate var uivcID : UInt8 = 42

  public typealias UXViewController = UIViewController

  extension UIViewController : UXUserInterfaceItemIdentification {

    public var uxViewController : UXViewController { return self }
    public var rootView         : UXView           { return view }

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
  
  extension UIViewController : UXViewControllerType {
  }
#endif // end: iOS
