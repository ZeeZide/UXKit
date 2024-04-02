//
//  UXKit
//
//  Copyright © 2016-2021 ZeeZide GmbH. All rights reserved.
//
#if os(macOS)
  import Cocoa

  public typealias UXWindow           = NSWindow
  public typealias UXView             = NSView
  public typealias UXResponder        = NSResponder
  public typealias UXControl          = NSControl
  public typealias UXLabel            = NSTextField
  public typealias UXTextField        = NSTextField
  public typealias UXSecureTextField  = NSSecureTextField
  public typealias UXScrollView       = NSScrollView
  public typealias UXCollectionView   = NSCollectionView
  public typealias UXSearchField      = NSSearchField
  public typealias UXSpinner          = NSProgressIndicator
  public typealias UXProgressBar      = NSProgressIndicator
  public typealias UXButton           = NSButton
  public typealias UXTextView         = NSTextView
  public typealias UXTextViewDelegate = NSTextViewDelegate
  public typealias UXPopUp            = NSPopUpButton
  public typealias UXStackView        = NSStackView
  public typealias UXCheckBox         = NSButton
  public typealias UXImageView        = NSImageView
  public typealias UXSlider           = NSSlider
  public typealias UXAccessibility    = NSAccessibility
  public typealias UXAccessibilityElement = NSAccessibilityElement

  // MARK: - UXUserInterfaceItemIdentification

  #if os(macOS) && swift(>=4.0)
    public typealias UXUserInterfaceItemIdentifier =
                       NSUserInterfaceItemIdentifier
  #else
    public typealias UXUserInterfaceItemIdentifier = String
  #endif
  
  public typealias UXUserInterfaceItemIdentification =
                     NSUserInterfaceItemIdentification

  
  // MARK: - UIView Compatibility
  
  public extension NSView {
    
    /// Set the needsLayout property to true. Use this for UIKit compat.
    final func setNeedsLayout() {
      needsLayout = true
    }
    
    /// Set the needsDisplay property to true. Use this for UIKit compat.
    /// Note: NSControl also has a setNeedsDisplay() function, presumably doing
    ///       the same.
    final func setNeedsDisplay() {
      // This is ambiguous on macOS 10.12? NSControl also has setNeedsDisplay()
      needsDisplay = true
    }
    
    /// Set the needsUpdateConstraints property to true. Use this for UIKit compat.
    final func setNeedsUpdateConstraints() {
      needsUpdateConstraints = true
    }
    
    var center: CGPoint {
      // TODO: On UIKit this can be set, can we emulate this? (if layer based
      //       maybe?)
      return CGPoint(x: NSMidX(frame), y: NSMidY(frame))
    }
    
    var alpha: CGFloat {
        get {
            return self.alphaValue
        }
        set {
            self.alphaValue = newValue
        }
    }
    
    func setSubViews(enabled: Bool) {
        self.subviews.forEach { subView in
            if subView.isKind(of: NSControl.self) {
                (subView as! NSControl).isEnabled = enabled
            }
        
            subView.setSubViews(enabled: enabled)
            
            subView.display()
        }
    }
    
    func isAnySubViewEnabled() -> Bool {
        var result : Bool = false
        
        var iterator = self.subviews.enumerated().makeIterator()
        
        var current = iterator.next()?.element
        
        while current != nil && !result {
            if current != nil {
                if current!.isKind(of: NSControl.self) {
                    result = (current as! NSControl).isEnabled
                }
            
                if !result {
                    result = current!.isAnySubViewEnabled()
                    
                    if !result {
                        current = iterator.next()?.element
                    }
                }
            }
        }
        
        return result
    }

    var isUserInteractionEnabled : Bool {
        get {
            return isAnySubViewEnabled()
        }
        
        set {
            setSubViews(enabled: newValue)
        }
    }

  }

  public extension NSProgressIndicator {
    // UIActivityIndicatorView has `isAnimating`, `startAnimation` etc.
    
    /// Use this instead of `start[stop]Animation` for UIKit compatibility.
    var isSpinning : Bool {
      set {
        if newValue { startAnimation(nil) }
        else        { stopAnimation (nil) }
      }
      get {
        // this is hackish, requires: isDisplayedWhenStopped == false
        return !isHidden
      }
    }
    
  }
  
  /// Add UISwitch `isOn` property. The AppKit variant has 3 states.
  public extension NSButton {
    
    #if swift(>=4.0)
      /// Use this instead of `state` for UIKit compatibility.
      var isOn: Bool {
        set { state = newValue ? .on : .off }
        get { return state == .on }
      }
    #else // Swift 3
      /// Use this instead of `state` for UIKit compatibility.
      public var isOn: Bool {
        set { state = newValue ? NSOnState : NSOffState }
        get { return state == NSOnState }
      }
    #endif
  }
  
  public extension NSTextField {
    
    /// Use this instead of `alignment` for UIKit compatibility.
    var textAlignment: NSTextAlignment {
      set { alignment = newValue }
      get { return alignment }
    }
        
    var text : String? {
        get {
            return self.stringValue
        }
        set {
            if let nv = newValue {
                self.stringValue = nv
            } else {
                self.stringValue = ""
            }
        }
    }
    
    var placeholder : String? {
        get {
            return self.placeholderString
        }
        set {
            if let nv = newValue {
                self.placeholderString = nv
            } else {
                self.placeholderString = ""
            }
        }
    }
    
  }

  // provides a cross-compatible delegate protocol.
public protocol UXTextFieldDelegate : NSTextFieldDelegate {
    func textField(_ textField: UXTextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool

    func textFieldDidBeginEditing(_ textField: UXTextField)

    func textFieldDidEndEditing(_ textField: UXTextField)

    func textFieldShouldReturn(_ textField: UXTextField) -> Bool
  }

open class VerticallyCenteredTextFieldCell: NSTextFieldCell {
    
    fileprivate var isEditingOrSelecting : Bool = false
    
    open override func drawingRect(forBounds rect: NSRect) -> NSRect {
        let rect = super.drawingRect(forBounds: rect)
        
        if !isEditingOrSelecting {
            let size = cellSize(forBounds: rect)
            return NSRect(x: rect.minX, y: rect.minY + (rect.height - size.height) / 2, width: rect.width, height: size.height)
        }
        
        return rect
    }
    
    open override func select(withFrame rect: NSRect, in controlView: NSView, editor textObj: NSText, delegate: Any?, start selStart: Int, length selLength: Int) {
        let aRect = self.drawingRect(forBounds: rect)
        isEditingOrSelecting = true
        super.select(withFrame: aRect, in: controlView, editor: textObj, delegate: delegate, start: selStart, length: selLength)
        isEditingOrSelecting = false
    }
    
    open override func edit(withFrame rect: NSRect, in controlView: NSView, editor textObj: NSText, delegate: Any?, event: NSEvent?) {
        let aRect = self.drawingRect(forBounds: rect)
        isEditingOrSelecting = true
        super.edit(withFrame: aRect, in: controlView, editor: textObj, delegate: delegate, event: event)
        isEditingOrSelecting = false
    }
    
}

  public extension UXSpinner {
    /// Use this instead of `isDisplayedWhenStopped` for UIKit compatibility.
    var hidesWhenStopped : Bool {
      set { isDisplayedWhenStopped = !newValue }
      get { return !isDisplayedWhenStopped }
    }
  }

  public extension UXView {
    
    func inOwnContext(execute: () -> ()) {
      NSGraphicsContext.saveGraphicsState()
      defer { NSGraphicsContext.restoreGraphicsState() }
      
      execute()
    }
    
    func withDisabledAnimations(execute: () ->() ) {
      CATransaction.begin()
      CATransaction.setDisableActions(true)
      defer { CATransaction.commit() }

      execute()
    }

  }

public extension UXAccessibility {
    
    static func post(notification: UXAccessibility.Notification,
                     argument: Any) {
        if notification == .announcementRequested {
            let userInfo = [ NSAccessibility.NotificationUserInfoKey.announcement : argument, NSAccessibility.NotificationUserInfoKey.priority : NSAccessibilityPriorityLevel.medium]
            
            if let window = NSApplication.shared.mainWindow {
                NSAccessibility.post(element: window, notification: notification, userInfo: userInfo)
            }
        } else {
            let userInfo : [ NSAccessibility.NotificationUserInfoKey : Any ]
            
            if let children = argument as? Array<Any> {
                userInfo = [.uiElements : children]
            } else {
                userInfo = [.uiElements : [argument]]
            }
            
            if let window = NSApplication.shared.mainWindow {
                NSAccessibility.post(element: window, notification: notification, userInfo: userInfo)
            }
        }
    }
}
#endif // os(macOS)
