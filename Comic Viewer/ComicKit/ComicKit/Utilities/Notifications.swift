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

