//
//  JSONResponseProtocol.swift
//  Comic Viewer
//
//  Created by Myles Eynon on 14/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//

import SwiftyJSON

public protocol JSONResponseProtocol {
    /** Factory Used to initialize the object from JSON data */
    static func fromJson(json: JSON) -> JSONResponseProtocol?
}

/** Operators */

public func ~~> <T: JSONResponseProtocol> (json: JSON, key: String) -> [T]? {
    
    
    //Watch out!
    //when the service returns a list of just one item. It is not in an array, but the single item moves up the graph
    
    if let _ = json[key].dictionary {
        return [T.fromJson(json: json[key]) as! T]
    }
    
    if let array = json[key].array {
        return array.flatMap { T.fromJson(json: $0) } as? [T]
    }
    return nil
}

public func ~~> <T: JSONResponseProtocol> (json: JSON, key: String) -> T? {
    if json[key] != JSON.null {
        return T.fromJson(json: json[key]) as? T
    }
    return nil
}


