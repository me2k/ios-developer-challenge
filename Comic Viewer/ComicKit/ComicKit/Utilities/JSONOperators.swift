//
//  JSONOperators.swift
//  Comic Viewer
//
//  Created by Myles Eynon on 13/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//


import SwiftyJSON

//MARK: ~~>
/** customer operator for extracting JSON values safely */

infix operator ~~>

public func ~~> (json: JSON, key: String) -> Int {
    return json[key].intValue
}

public func ~~> (json: JSON, key: String) -> Int? {
    return json[key].int
}

public func ~~> (json: JSON, key: String) -> [Int] {
    return json[key].arrayValue.flatMap { $0.intValue }
}

public func ~~> (json: JSON, key: String) -> [Int]? {
    return json[key].arrayValue.flatMap { $0.intValue }
}

public func ~~> (json: JSON, key: String) -> UInt {
    return json[key].uIntValue
}

public func ~~> (json: JSON, key: String) -> UInt? {
    return json[key].uInt
}

public func ~~> (json: JSON, key: String) -> Float {
    return json[key].floatValue
}

public func ~~> (json: JSON, key: String) -> String {
    return json[key].stringValue
}

public func ~~> (json: JSON, key: String) -> String? {
    //If string is empty, should return nil
    if let result = json[key].string , result.count > 0 {
        return result
    }
    return nil
}

public func ~~> (json: JSON, key: String) -> [String] {
    return json[key].arrayValue.flatMap { $0.stringValue }
}

public func ~~> (json: JSON, key: String) -> Bool {
    return json[key].boolValue
}

public func ~~> (json: JSON, key: String) -> Bool? {
    return json[key].bool
}

public func ~~> (json: JSON, key: String) -> [JSON]? {
    return json[key].array
}

public func ~~> (json: JSON, key: String) -> NSNumber? {
    let string = json[key].stringValue
    if let value = Double(string) {
        return NSNumber(value: value)
    }
    return nil
}

public func ~~> (json: JSON, key: String) -> Double {
    return json[key].doubleValue
}

public func ~~> (json: JSON, key: String) -> Double? {
    return json[key].double
}

public func ~~> (json: JSON, key: String) -> CGFloat {
    return CGFloat(json[key].floatValue)
}

public func ~~> (json: JSON, key: String) -> CGFloat? {
    if let float = json[key].float {
        return CGFloat(float)
    }
    return nil
}