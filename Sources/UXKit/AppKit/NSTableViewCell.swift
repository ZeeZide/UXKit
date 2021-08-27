//
//  UXKit
//
//  Copyright © 2016-2019 ZeeZide GmbH. All rights reserved.
//
#if os(macOS)
  import Cocoa
  
  /**
   * This is a cell which can actually produce its subviews. Similar to
   * `UITableViewCell`.
   * Remember that `NSTableCellView` is more like a protocol.
   *
   * Use `UXTableViewCellType` when referring to a cell in an abstract way,
   * and `UXTableViewCell` for this concrete type (or the UIKit version).
   *
   * This view lazily creates the backing views when you access them:
   *
   *     cell.textLabel?      .stringValue = "Hello!"
   *     cell.detailTextLabel?.stringValue = "World"
   *
   * NOTE: This one doesn't actually support an image :-/
   */
  open class NSTableViewCell : NSTableCellView, NSTextFieldDelegate {
    // Note: UITableViewCell has many more views to show selection state,
    //       regular background, etc.
    
    // TODO: We need to track selection for proper text colors (as discussed w/
    //       ZNeK?)
    //       Setting the color of the label, breaks things.
    
    private enum ViewSetup : Equatable {
      // TBD: this is kinda like UXTableViewCellStyle
      case none
      case image
      case label
      case imageLabel
      case imageLabelDetail
      case labelDetail
    }
    
    private struct Style {
      let padding      : CGFloat = 8.0
      let labelPadding : CGFloat = 4.0
      
      #if swift(>=4.0)
        let labelSize       = UXFont.systemFontSize + 4.0
        let detailLabelSize = UXFont.smallSystemFontSize
      #else
        let labelSize       = UXFont.systemFontSize() + 4.0
        let detailLabelSize = UXFont.smallSystemFontSize()
      #endif
      
      //let detailColor     = UXColor.secondaryLabelColor  // 10.10
      let detailColor     = UXColor.darkGray
    }
    private let style = Style()
    
    // provided for compatibility, though not really used.
    public enum SelectionStyle : Int {
      case none = 0
      case blue = 1
      case gray = 2
      @available(iOS 7.0, *)
      case `default` = 3
    }

    public var selectionStyle : SelectionStyle = .default

    // provided for compatibility, though not really used.
    public enum AccessoryType : Int {
        case none = 0 // don't show any accessory view
        case disclosureIndicator = 1 // regular chevron. doesn't track
        case detailDisclosureButton = 2 // info button w/ chevron. tracks
        case checkmark = 3 // checkmark. doesn't track
        
        @available(iOS 7.0, *)
        case detailButton = 4 // info button. tracks
    }

    public var accessoryType : AccessoryType = .none

    
    // provided for compatibility, though not really used.
    public enum EditingStyle : Int {
        case none = 0
        case delete = 1
        case insert = 2
    }

    // These are provided for UIKit compatibility.  Not actively used (yet).
    public var backgroundColor : UXColor {
        get {
            if let col = self.layer?.backgroundColor {
                return UXColor(cgColor: col)!
            }
            
            return UXColor.textBackgroundColor
        }
        
        set {
            self.layer?.backgroundColor = newValue.cgColor
        }
    }

    public init(style: UXTableViewCellStyle, reuseIdentifier id: String?) {
      /* TODO: SETUP:
       default:  just label, no detail
       value1:   label on the left, gray detail on the right (same row)
       value1:   blue lable on the left 1/4, black detail on the right (same row)
       subtitle: label, below gray detail (two rows)
       */
      editing = false
        
      super.init(frame: UXRect())
      
      if let id = id {
        self.identifier = UXUserInterfaceItemIdentifier(id)
      }
    }
    public convenience init(style: UXTableViewCellStyle,
                            reuseIdentifier id: UXUserInterfaceItemIdentifier?)
    {
      self.init(style: style, reuseIdentifier: id?.rawValue)
    }
    public required init?(coder decoder: NSCoder) {
      fatalError("\(#function) not implemented")
    }

    private var installedConstraintSetup = ViewSetup.none
    private var requiredConstraintSetup : ViewSetup {
      switch ( _textLabel, _detailTextLabel ) {
        case ( .none, .none ): return .none
        case ( .some, .none ): return .label
        case ( .some, .some ): return .labelDetail
        case ( .none, .some ): return .labelDetail // no detail w/o main
      }
    }
    private var installedConstraints = [ NSLayoutConstraint ]()
    
    override open func updateConstraints() {
      super.updateConstraints()
      
      let required = requiredConstraintSetup
      guard installedConstraintSetup != required else { return }
      // Swift.print("from \(installedConstraintSetup) to \(required)")
      
      NSLayoutConstraint.deactivate(installedConstraints)
      installedConstraints.removeAll()
      
      let pad = style.padding
        // TBD: is that contentInset or something on the tableview?

      switch required {
        case .none: break
        
        case .label:
          installedConstraints = [
            constrain(textLabel, .leading,  to: self, constant: pad),
            constrain(textLabel, .trailing, to: self, constant: -pad),
            /*
             constrain(label, .top,      to: self),
             constrain(label, .bottom,   to: self)
             */
            constrain(self, .height, to: textLabel), // TBD
            constrain(textLabel, .centerY, to: self)
          ]
        
        case .labelDetail:
          installedConstraints = [
            constrain(textLabel,       .leading,  to: self, constant: pad),
            constrain(textLabel,       .trailing, to: self, constant: -pad),
            constrain(detailTextLabel, .leading,  to: self, constant: pad),
            constrain(detailTextLabel, .trailing, to: self, constant: -pad),
            
            constrain(textLabel,       .top,      to: self, constant: pad),
            constrain(detailTextLabel, .top,      to: textLabel, .bottom,
                      constant: style.labelPadding),
            constrain(self, .bottom, to: detailTextLabel, constant: pad), // TBD
          ]
        
        default:
          break // TBD: remove
      }
      
      installedConstraintSetup = required
      NSLayoutConstraint.activate(installedConstraints)
    }
    
    // do we need an actual view? or just self as compat?
    open var contentView : UXView { return self }
    
    var _textLabel : UXLabel? = nil
    open var textLabel : UXLabel? {
      set {
        if newValue === _textLabel { return }
        _textLabel?.removeFromSuperview()
        _textLabel = newValue
        setNeedsUpdateConstraints()
      }
      get {
        if let label = _textLabel { return label }
        
        let label = makeLabel()
        label.font = UXFont.systemFont(ofSize: style.labelSize)
        label.cell?.lineBreakMode = .byTruncatingTail

        #if false
          label.verticalAlignment = .middleAlignment // TBD: do we want this?
          // I'm still not quite sure why we even need this. The height of the
          // table-cell-view should be equal to the label height?!
        #endif
        
        #if false
          // editing support
          label.isEditable = true
          label.target     = self // VC
          label.action     = #selector(didEditTableRow(_:))
        #endif
        
        addSubview(label)
        #if false // this is funny, setting this overrides the font
          self.textField = label // this is weak!
        #endif
        _textLabel     = label
        setNeedsUpdateConstraints()
        return label
      }
    }

    public override var acceptsFirstResponder: Bool {
        get {
            return true
        }
    }
    
    public override func becomeFirstResponder() -> Bool {
        if !self.editing {
            self.editing = true

            if #available(macOS 10.14, *) {
                _textLabel?.backgroundColor = .selectedContentBackgroundColor
            } else {
                // Fallback on earlier versions
                _textLabel?.backgroundColor = .selectedMenuItemColor
            }

            _textLabel?.drawsBackground = true
            _textLabel?.isEditable = true
            _textLabel?.target = self
            _textLabel?.action = #selector(didEditTableRow(_ :))
            _textLabel?.becomeFirstResponder()
            _textLabel?.delegate = self

            return true
        }
        
        return false
    }
    
    public override func resignFirstResponder() -> Bool {
        if self.editing {
            self.editing = false
            _textLabel?.drawsBackground = false
            _textLabel?.abortEditing()
            _textLabel?.isEditable = false
        }
        
        return true
    }
    
    var editing : Bool
    
    @objc func didEditTableRow(_ editor: Any) {
        NSLog("row was edited")
        _ = self.resignFirstResponder()
    }

    public func controlTextDidEndEditing(_ obj: Notification) {
        NSLog("row edit aborted")
        _ = self.resignFirstResponder()
    }
    
    var _detailTextLabel : UXLabel? = nil
    open var detailTextLabel : UXLabel? {
      set {
        if newValue === _detailTextLabel { return }
        _detailTextLabel?.removeFromSuperview()
        _detailTextLabel = newValue
        setNeedsUpdateConstraints()
      }
      get {
        if let label = _detailTextLabel { return label }
        
        // FIXME: adjust size
        let label = makeLabel()
        label.font = UXFont.systemFont(ofSize: style.detailLabelSize)
        label.cell?.lineBreakMode = .byTruncatingTail
        
        label.textColor = style.detailColor
          // this fails with selection?!
        
        #if false
          label.verticalAlignment = .middleAlignment // TBD: do we want this?
          // I'm still not quite sure why we even need this. The height of the
          // table-cell-view should be equal to the label height?!
        #endif
        
        addSubview(label)
        _detailTextLabel = label
        setNeedsUpdateConstraints()
        return label
      }
    }
    
    // ups, this does not exist (breaks) in Swift 3.1 (Xcode 8)
    override open var backgroundStyle: NSView.BackgroundStyle {
      didSet {
        switch backgroundStyle {
          case .dark:
            _detailTextLabel?.textColor = NSColor.selectedTextColor
          default:
            _detailTextLabel?.textColor = style.detailColor
        }
      }
    }

    // MARK: - Separator line (TBD: should we draw this?)
    
    open var dividerColor : UXColor { return UXColor.lightGray }

    override open func draw(_ dirtyRect: UXRect) {
      super.draw(dirtyRect)
      
      inOwnContext { // TBD: required?
        let bp = UXBezierPath()
        bp.move(to: NSPoint(x: bounds.origin.x + style.padding,
                            y: bounds.origin.y))
        bp.line(to: NSPoint(x: bounds.size.width - style.padding,
                            y: bounds.origin.y))

        dividerColor.setStroke()
        bp.lineWidth = 0.5
        bp.stroke()
      }
    }
    
    
    // MARK: - Label Factory
    
    open func makeLabel() -> UXLabel {
        let v = UXLabel(frame: UXRect())
        v.cell = VerticallyCenteredTextFieldCell()
        v.translatesAutoresizingMaskIntoConstraints = false
        
        /* configure as label */
        v.isEditable      = false
        v.isBezeled       = false
        v.drawsBackground = false
        v.isSelectable    = false // not for raw labels
        
        /* common */
        v.alignment   = .center
        
        return v
    }
  }
  
  fileprivate func constrain(_ base: UXView?,
                             _ baseAttr: NSLayoutConstraint.Attribute,
                             to toItem: UXView? = nil,
                             _ toAttr: NSLayoutConstraint.Attribute? = nil,
                             constant: CGFloat? = nil)
                   -> NSLayoutConstraint
  {
    guard let base = base else { fatalError("did not specify base view") }
    let resolvedToAttr = toAttr ?? (toItem != nil ? baseAttr : .notAnAttribute)
    
    let c = NSLayoutConstraint(item       : base,
                               attribute  : baseAttr,
                               relatedBy  : .equal,
                               toItem     : toItem,
                               attribute  : resolvedToAttr,
                               multiplier : 1.0,
                               constant   : constant ?? 0)
    return c
  }
#endif // macOS
