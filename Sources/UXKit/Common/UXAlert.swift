//
//  UXAlert.swift
//  UXKit
//
//  Created by Helge Heß on 09.10.19.
//  Copyright © 2019 ZeeZide GmbH. All rights reserved.
//

#if os(macOS)
  import AppKit

  public typealias UXAlert = NSAlert


public extension UXAlert.Style {
    
    static let alert : UXAlert.Style = .warning
}

public class UXAlertAction {
    public enum Style : Int {
        case `default` = 0
        case cancel
        case destructive
    }
    
    var style : Style
    var title : String?
    var handler : ((UXAlertAction) -> Void)?
    
    public init(title: String?,
               style: UXAlertAction.Style,
               handler: ((UXAlertAction) -> Void)? = nil) {
        self.style = style
        self.title = title
        self.handler = handler
    }
}

public extension UXAlert {
    convenience init(title: String?,
             message: String?,
             preferredStyle: UXAlert.Style) {
        self.init()
        
        if title != nil {
            self.messageText = title!
        }
        
        if message != nil {
            self.informativeText = message!
        }
        
        self.alertStyle = preferredStyle
    }
    
    func addAction(_ action: UXAlertAction) {
        // The idea here was to tune the visualisation of the buttons in a manner similar to UIKit,
        // but at this time, I don't know how to.
        switch action.style {
        case .default:
            self.addButton(withTitle: action.title!)
        case .cancel:
            self.addButton(withTitle: action.title!)
        case .destructive:
            self.addButton(withTitle: action.title!)
        }
    }
}

#elseif os(iOS)
  import UIKit

  public typealias UXAlert = UIAlertController
  public typealias UXAlertAction = UIAlertAction

  public extension UIAlertController {
    
    /// AppKit NSAlert version of `title`
    var messageText : String? {
      set { title = newValue }
      get { return title }
    }
    
    /// AppKit NSAlert version of `message`
    var informativeText : String? {
      set { message = newValue }
      get { return message }
    }
  }

#endif
