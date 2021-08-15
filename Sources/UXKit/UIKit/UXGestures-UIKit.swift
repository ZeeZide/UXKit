//
//  UXKit
//
//  Copyright © 2016-2019 ZeeZide GmbH. All rights reserved.
//
#if !os(macOS)
  import UIKit

  public typealias UXGestureRecognizer         = UIGestureRecognizer
  public typealias UXGestureRecognizerDelegate = UIGestureRecognizerDelegate
  public typealias UXRotationGestureRecognizer = UIRotationGestureRecognizer
  public typealias UXPanGestureRecognizer      = UIPanGestureRecognizer
  public typealias UXTapGestureRecognizer      = UITapGestureRecognizer
  public typealias UXPinchGestureRecognizer    = UIPinchGestureRecognizer
  // public typealias UXSwipeGestureRecognizer = UISwipeGestureRecognizer
  //   AppKit has separate 'click' and 'press'

  
  public extension UIRotationGestureRecognizer {
    
    var rotationInDegrees : CGFloat {
      // macOS has it, iOS doesn't
      return rotation * 180 / .pi
    }
    
  }

  public extension UIView {
    
    @discardableResult
    func on(gesture gr: UXGestureRecognizer,
            target: AnyObject, action: Selector) -> Self
    {
      gr.addTarget(target, action: action)
      addGestureRecognizer(gr)
      return self
    }
    
  }
#endif // !os(macOS)
