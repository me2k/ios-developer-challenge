//
//  Notifications.swift
//  Comic Viewer
//
//  Created by Myles Eynon on 13/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//


import UIKit

/** Just a bunch of notifications */
public enum Notifications: String {
    
    //Reachability
    case reachabilityOffline = "com.comicviewer.reachabilityOffline"
    case reachabilityOnline = "com.comicviewer.reachabilityOnline"
    
    // APP Delegate events
    case appWillEnterBackgroundNotification = "com.comicviewer.appWillEnterBackgroundNotification"
    case appWillEnterForegroundNotification = "com.comicviewer.appWillEnterForegroundNotification"
    case appBecameActiveNotification = "com.comicviewer.appBecameActiveNotification"
    
    
    public var name: NSNotification.Name {
        return NSNotification.Name(rawValue: self.rawValue)
    }
    
    /** Posts the notification */
    public func post(_ payload: NSObject? = nil) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: self.name, object: payload)
        }
    }
    
    public func post(_ payload: NSObject? = nil, userInfo: [AnyHashable : Any]? = nil) {
        DispatchQueue.main.async {
            NotificationCenter.default.post(name: self.name, object: payload, userInfo: userInfo)
        }
    }
}

public extension Notifications {
    
    public typealias KeyboardSelector = ((Notification) -> ())
    
    public static func addKeyboardNotifications(_ forSelf: NSObject, willShow: Selector, willHide: Selector, didShow: Selector, didHide: Selector) {
        NotificationCenter.default.addObserver(forSelf, selector: willShow, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(forSelf, selector: willHide, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(forSelf, selector: didShow, name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(forSelf, selector: didHide, name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    
    public static func removeKeyboardNotifications(_ forSelf: NSObject) {
        NotificationCenter.default.removeObserver(forSelf, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(forSelf, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.removeObserver(forSelf, name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.removeObserver(forSelf, name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
}


