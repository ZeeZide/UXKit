//
//  UXGestureActions.swift
//  UXKit
//
//  Created by Helge Hess on 05.12.17.
//  Copyright © 2017 ZeeZide GmbH. All rights reserved.
//

import Foundation

public extension UXView {
  
  @discardableResult
  func onRotation(_ target: AnyObject, _ action: Selector) -> Self {
    return on(gesture: UXRotationGestureRecognizer(),
              target: target, action: action)
  }
  
  @discardableResult
  func onPan(_ target: AnyObject, _ action: Selector) -> Self {
    return on(gesture: UXPanGestureRecognizer(), target: target, action: action)
  }
  
  @discardableResult
  func onTap(_ target: AnyObject, _ action: Selector) -> Self {
    return on(gesture: UXTapGestureRecognizer(), target: target, action: action)
  }
  
  @discardableResult
  func onPinch(_ target: AnyObject, _ action: Selector) -> Self {
    return on(gesture: UXPinchGestureRecognizer(),
              target: target, action: action)
  }
  
}
