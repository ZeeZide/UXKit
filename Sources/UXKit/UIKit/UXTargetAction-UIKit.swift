//
//  UXKit
//
//  Copyright © 2016-2017 ZeeZide GmbH. All rights reserved.
//
#if !os(macOS)
  import UIKit

  public extension UIButton {
    
    // MARK: - Target/Action
    
    @discardableResult
    func onClick(_ target: AnyObject?, _ action: Selector) -> Self {
      addTarget(target, action: action, for: .touchUpInside)
      return self
    }
    
  }
  
#endif
