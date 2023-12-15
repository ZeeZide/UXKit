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

/// A UIKit style AlertAction to provide code compatibility to the enclosing application.
/// Use this to add an 'action' to a UXAlert.
///
public class UXAlertAction {
    
    /// The style of the action / button
    public enum Style : Int {
        case `default` = 0
        case cancel
        case destructive
    }
    
    /// Action style
    var style : Style
    
    /// Action title.
    var title : String?
    
    /// The handler block for the action.
    var handler : ((UXAlertAction) -> Void)?
    
    /// These properties are used to allow the action to insert itself into the responder chain for when the
    /// action is triggered.
    ///
    private var chainingButton : NSButton?
    private var chainedTarget : AnyObject?
    private var chainedSelector : Selector?
    
    /// Initialise the action with the supplied parameters.
    /// - Parameters:
    ///   - title: the title for the action; this will be the text of the button (pre-localized)
    ///   - style: the style of the action; used to change the L&F of the button.
    ///   - handler: a block that will be called when the action is triggered by the alert..
    public init(title: String?,
               style: UXAlertAction.Style,
               handler: ((UXAlertAction) -> Void)? = nil) {
        self.style = style
        self.title = title
        self.handler = handler
    }
    
    /// A method that can be called by the alert when the associated button is pressed.
    @objc func action(sender: AnyObject?) {
        // If we actually have a handler, then call it.
        if let handlerBlock = self.handler {
            handlerBlock(self)
        }
        
        // If there is a chained button, then call whatever action it was given by
        // AppKit when the button was created.
        //
        if chainingButton != nil &&
            chainedTarget != nil &&
            chainedSelector != nil {
            if let target = chainedTarget as? NSObject {
                if target.responds(to: chainedSelector) {
                    target.perform(chainedSelector, with: sender)
                }
            }
        }
    }
    
    /// Inserts the action into the responder chain by first preserving whatever action AppKit
    /// gave to the button when it was created, and then inserting this action.
    /// - Parameter button: the button to be chained to.
    func chainAction(toButton button: NSButton) {
        // first preserve a reference to the button and it's current action.
        self.chainingButton = button
        self.chainedTarget = button.target
        self.chainedSelector = button.action
        
        // now override the button action so that it triggers this action.
        //
        button.target = self
        button.action = #selector(action)
    }
}

/// An extension to NSAlert that adds a layer of code compatibility for apps that need to work on both UIKit and AppKit.
public extension UXAlert {
    
    
    /// Initialise a new UXAlert with the provided parameters.
    /// - Parameters:
    ///   - title: a pre-localized title for the alert
    ///   - message: a pre-localized message for the alert
    ///   - preferredStyle: the preferred style of the alert
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
    
    /// Adds a single UXAlertAction to the alert, presenting it as a button.  Due to the way NSAlert works in
    /// AppKit, it is recommended that the "default" action be added first.  Destructive buttons should never
    /// be added first as AppKit ignores some of the styling that would normally happen for destructive buttons
    /// when they are also the "default" button.
    /// - Parameter action: the action to be added.
    func addAction(_ action: UXAlertAction) {
        switch action.style {
        case .default:
            let button = self.addButton(withTitle: action.title!)
            action.chainAction(toButton: button)
        case .cancel:
            let button = self.addButton(withTitle: action.title!)
            action.chainAction(toButton: button)
        case .destructive:
            let button = self.addButton(withTitle: action.title!)
            action.chainAction(toButton: button)

            if #available(macOS 11.0, *) {
                button.hasDestructiveAction = true
            } else {
                if #available(macOS 10.14, *) {
                    button.contentTintColor = .red
                }
            }
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
