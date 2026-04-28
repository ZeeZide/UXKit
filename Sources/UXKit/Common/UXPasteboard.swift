//
//  UXKit
//
//  Copyright © 2016-2020 ZeeZide GmbH. All rights reserved.
//
#if os(macOS)
  import AppKit
  import class Cocoa.NSPasteboard
  
  public typealias UXPasteboard = NSPasteboard
  
  public extension NSPasteboard {

    func canReadItem(withDataConformingToType type: NSPasteboard.PasteboardType)
         -> Bool
    {
      return canReadItem(withDataConformingToTypes: [ type.rawValue ])
    }

    func canReadItem(withDataConformingToTypes types:
                        [ NSPasteboard.PasteboardType ]) -> Bool
    {
      // The default function does not work w/ PasteboardType ...
      return canReadItem(withDataConformingToTypes: types.map { $0.rawValue })
    }
      
      var hasURLs: Bool {
          get {
              return canReadItem(withDataConformingToType: .URL)
          }
      }
      
      var hasImages: Bool {
          get {
              return canReadItem(withDataConformingToType: .png) ||
              canReadItem(withDataConformingToType: .tiff)
          }
      }
      
      var image: NSImage? {
          get {
              return images?.first
          }
      }
      
      var images: [NSImage]? {
          get {
              return readObjects(forClasses: [NSImage.self]) as? [NSImage]
          }
      }
      
      var url: URL? {
          get {
              return urls?.first
          }
      }

      var urls: [URL]? {
          get {
              if let intermediateResult: [NSURL] = readObjects(forClasses: [NSURL.self]) as? [NSURL] {
                  var result: [URL] = []
                  intermediateResult.forEach { nsURL in
                      result.append(nsURL as URL)
                  }
                  return result
              } else {
                  return nil
              }
          }
      }
      
      var string: String? {
          get {
              return strings?.first
          }
      }

      var strings: [String]? {
          get {
              if let intermediateResult: [NSString] = readObjects(forClasses: [NSString.self]) as? [NSString] {
                  var result: [String] = []
                  intermediateResult.forEach { nsString in
                      result.append(nsString as String)
                  }
                  return result
              } else {
                  return nil
              }
          }
      }

  }
#elseif !os(tvOS) // !os(macOS)
  import class UIKit.UIPasteboard
  
  public typealias UXPasteboard = UIPasteboard
  
  public extension UIPasteboard {
    
    typealias PasteboardType = String
    
    /**
     * Before you can provide new content to the pasteboard on AppKit, you need
     * to clear it.
     * Not quite sure why this doesn't exist on iOS? Are we supposed to reset
     * specific pasteboards?
     */
    @discardableResult
    func clearContents() -> Int {
      return changeCount
    }
  }
#endif // !os(macOS)
