//
//  UXKit
//
//  Copyright © 2016-2017 ZeeZide GmbH. All rights reserved.
//
#if os(macOS)
  import Cocoa
  
  public extension NSButton {
    
    @discardableResult
    func onClick(_ target: AnyObject?, _ action: Selector) -> Self {
      self.target = target
      self.action = action
      return self
    }
  }
  
  public extension NSPopUpButton {
    
    @discardableResult
    public func onChange(_ target: AnyObject?, _ action: Selector) -> Self {
      self.target = target
      self.action = action
      return self
    }
  }
  
  public extension NSTableView {
    
    @discardableResult
    public func onClick(_ target: AnyObject?, _ action: Selector) -> Self {
      self.target = target
      self.action = action
      return self
    }
    
    @discardableResult
    public func onDoubleClick(_ target: AnyObject?, _ action: Selector) -> Self
    {
      if self.target != nil && target !== self.target {
        print("setting different target for double-click action:", self,
              "\n  old:", self.target ?? "-",
              "\n  new:", target      ?? "-")
      }
      
      self.target       = target
      self.doubleAction = action
      return self
    }
  }
#endif
