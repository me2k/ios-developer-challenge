//
//  JSONDate.swift
//  Comic Viewer
//
//  Created by Myles Eynon on 13/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//

import SwiftyJSON

public extension JSON {
    
    public var dateValue: Date {
        get {
            return Formatter.dateFrom(json: stringValue)!
        }
    }
    
    /** Attempts to get a date and time, or a date only from the json */
    public var date: Date? {
        get {
            if let str = self.string {
                if let result = Formatter.dateFrom(json: str) {
                    return result
                } else if let result = Formatter.isoDateFrom(json: str) {
                    return result
                } else if let result = Formatter.iso2DateFrom(json: str) {
                    return result
                } else if let result = Formatter.iso8601DateFrom(json: str) {
                    return result
                } else if let result = Formatter.dateOnlyFrom(json: str) {
                    return result
                }
            } else if let interval = self.double {
                return Date(timeIntervalSince1970: interval / 1000) //the timestamps from the server are in miliseconds
            }
            return nil
        }
    }
}

