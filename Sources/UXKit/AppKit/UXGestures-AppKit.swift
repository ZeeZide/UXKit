//
//  UXKit
//
//  Copyright © 2016-2017 ZeeZide GmbH. All rights reserved.
//
#if os(macOS)
  import Cocoa
  
  public typealias UXGestureRecognizer         = NSGestureRecognizer
  public typealias UXGestureRecognizerDelegate = NSGestureRecognizerDelegate
  public typealias UXRotationGestureRecognizer = NSRotationGestureRecognizer
  public typealias UXPanGestureRecognizer      = NSPanGestureRecognizer
  public typealias UXTapGestureRecognizer      = NSClickGestureRecognizer
  public typealias UXPinchGestureRecognizer = NSMagnificationGestureRecognizer
  // No Swipe?
  //   but AppKit has a 'Press' in addition to 'Click'

  public extension NSView {
    
    enum SwipeDirection {
        case none
        case left
        case right
        case up
        case down
    }
    
    @discardableResult
    func on(gesture gr: UXGestureRecognizer,
            target: AnyObject, action: Selector) -> Self
    {
      gr.target = target // UIKit requires a target
      gr.action = action
      addGestureRecognizer(gr)
      return self
    }
    
    // This is how macOS handles Swipe gestures.
    override func swipe(with event: NSEvent) {
        let x : CGFloat = event.deltaX
        let y : CGFloat = event.deltaY
        var direction : SwipeDirection = .none
        
        if (x != 0) {
            direction = (x > 0)  ? .left : .right
        } else if (y != 0) {
            direction = (y > 0)  ? .up : .down
        }
        
        self.swipeGestureRecognized(inDirection: direction)
    }
    
    // Override this if you want to receive swipe gestures on your NSView.
    func swipeGestureRecognized(inDirection direction: SwipeDirection) {
    }
    
  }
  
  public extension UXTapGestureRecognizer {
    // Note: NSClickGestureRecognizer
    // - numberOfClicksRequired
    // - numberOfTouchesRequired (10.12.2)
    
    var numberOfTapsRequired: Int {
      set { numberOfClicksRequired = newValue }
      get { return numberOfClicksRequired }
    }
  }
#endif
