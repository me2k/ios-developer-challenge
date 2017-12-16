//
//  ReachabilityManager.swift
//  Comic Viewer
//
//  Created by Myles Eynon on 13/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//


import Alamofire

public class ReachabilityManager {
    
    private var reachabilityManager = NetworkReachabilityManager(host: "www.google.com") //AppEnvironment.environment.baseServiceURL()
    
    public var status = NetworkReachabilityManager.NetworkReachabilityStatus.unknown
    
    public var previousStatus = NetworkReachabilityManager.NetworkReachabilityStatus.unknown
    
    
    static var instance = ReachabilityManager()
    
    public func listenForReachability() {
        self.reachabilityManager?.listener = { status in
            self.previousStatus = self.status
            self.status = status
            switch status {
            case .notReachable:
                debugPrint("We're Offline!")
                Notifications.reachabilityOffline.post()
                
            case .reachable(.ethernetOrWiFi):
                debugPrint("We're Online with WiFi")
                Notifications.reachabilityOnline.post()
                
            case .unknown:
                debugPrint("We're Online with Unknown")
                Notifications.reachabilityOnline.post()
                
            case .reachable(.wwan):
                debugPrint("We're Online with Mobile")
                Notifications.reachabilityOnline.post()
            }
        }
        self.reachabilityManager?.startListening()
    }
    
    deinit {
        self.reachabilityManager?.stopListening()
    }
}



