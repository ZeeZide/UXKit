//
//  UXKit
//
//  Copyright © 2016-2017 ZeeZide GmbH. All rights reserved.
//

import Foundation

@objc public protocol UXViewControllerType
                      : UXObjectPresentingType,
                        UXUserInterfaceItemIdentification
{
  // Too bad that we can't adopt NSViewController as a protocol.
}

#if os(macOS)
  import Cocoa
  
  extension NSViewController : UXViewControllerType {
  }
  
#else // iOS
  import UIKit
  
  fileprivate var uivcID : UInt8 = 42

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
  
  extension UIViewController : UXViewControllerType {
  }
#endif // end: iOS
