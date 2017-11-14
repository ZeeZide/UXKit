//
//  UXKit
//
//  Copyright © 2016-2017 ZeeZide GmbH. All rights reserved.
//
#if !os(macOS)
  import UIKit
  
  public typealias UXTableView          = UITableView

  /**
   * This is the type of the view a tableview datasource is expected to return
   * (when creating a view for a row).
   *
   * On AppKit, this can be any view, but on UIKit, it *must* be a
   * UITableViewCell.
   *
   * Also note that on AppKit there is a `NSTableCellView`. This is *not* the
   * same like the `UITableViewCell`! The `NSTableCellView` doesn't create its
   * contents, but purely serves as an outlet holder for IB.
   *
   * To workaround that, we provide an own `NSTableViewCell` which tries to
   * mirror what `UITableViewCell` does.
   */
  public typealias UXTableViewCellType  = UITableViewCell
  
  /**
   * A concrete view which you can use in a view datasource. It provides an
   * image, label, detail-label, and a set of different styles.
   *
   * On iOS, this is builtin via `UITableViewCell`, and on macOS we provide
   * an own class for that (`NSTableViewCell`).
   */
  public typealias UXTableViewCell      = UITableViewCell // same on iOS
  
  public typealias UXTableViewCellStyle = UITableViewCellStyle

  public protocol UXTableViewCellInit : class {
    init(style: UXTableViewCellStyle, reuseIdentifier: String?)
    func prepareForReuse()
  }

  public extension UITableViewRowAnimation {
    public static var effectFade = UITableViewRowAnimation.fade
    public static var effectGap  = UITableViewRowAnimation.middle // TBD
    public static var slideUp    = UITableViewRowAnimation.top
    public static var slideDown  = UITableViewRowAnimation.bottom
    public static var slideLeft  = UITableViewRowAnimation.left
    public static var slideRight = UITableViewRowAnimation.right
  }

  public extension UITableView {
    // TBD: maybe we should hide those and just use the iOS versions
    
    public func insertRows(at indexes: IndexSet,
                           withAnimation ao : UITableViewRowAnimation
                                            = .automatic)
    {
      // fade, right, left, top, bottom, none, middle, automatic
      insertRows(at: indexes.map { IndexPath(row: $0, section: 0)}, with: ao)
    }
    
    public func removeRows(at indexes: IndexSet,
                           withAnimation ao : UITableViewRowAnimation
                                            = .automatic)
    {
      deleteRows(at: indexes.map { IndexPath(row: $0, section: 0)}, with: ao)
    }
    
    public func reloadData(forRowIndexes rows: IndexSet,
                           columnIndexes cols: IndexSet)
    {
      reloadRows(at: rows.map { IndexPath(row: $0, section: 0)},
                 with: .none) // This: flickrs too much: .automatic
    }
  }
#endif
