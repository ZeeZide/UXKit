//
//  UXKit
//
//  Copyright © 2016-2017 ZeeZide GmbH. All rights reserved.
//
#if !os(macOS)
  import UIKit
  
  public typealias UXCollectionViewLayout           = UICollectionViewLayout
  public typealias UXCollectionViewFlowLayout       = UICollectionViewFlowLayout
  public typealias UXCollectionViewLayoutAttributes =
                       UICollectionViewLayoutAttributes
  public typealias UXCollectionViewDataSource       = UICollectionViewDataSource
  public typealias UXCollectionViewDelegate         = UICollectionViewDelegate
  public typealias UXCollectionViewDelegateFlowLayout =
                       UICollectionViewDelegateFlowLayout
  public typealias UXCollectionViewItem             = UICollectionViewCell

  
  public extension UICollectionView {
    
    public var isSelectable : Bool { // Cocoa compat
      set { allowsSelection = newValue }
      get { return allowsSelection }
    }
    
    public var selectionIndexPaths : [ IndexPath ] {
      return indexPathsForSelectedItems ?? []
    }
    
  }
#endif
