//
//  DependencyInjector.swift
//  ComicKit
//
//  Created by Myles Eynon on 16/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//


import UIKit

/** A method of providing depenency injection */
class DependencyInjector {
    
    /** A key that associates a type with a factory constructor */
    struct DependencyKey: Hashable, Equatable {
        var protocolType: Any.Type
        var hashValue: Int { return "\(protocolType)".hashValue }
    }
    
    private var dependencies = [DependencyKey: ()->Any]()
    
    /**
     Register a factory constructor for an implied Type
     - Note: use like this: Services.register({ Authority() as iAuthority })
     */
    func register<T>(_ factory: @escaping () -> T) {
        
        let key = DependencyKey(protocolType: T.self)
        dependencies[key] = factory
    }
    
    /** Resolves the implied Type to its stored factory constructor */
    func resolve<T>() -> T {
        let key = DependencyKey(protocolType: T.self)
        
        guard let factory = dependencies[key] else { fatalError("Factory not registered for \(key.protocolType)") }
        return factory() as! T
    }
}

func ==(lhs:DependencyInjector.DependencyKey, rhs:DependencyInjector.DependencyKey) -> Bool {
    return lhs.protocolType == rhs.protocolType
}

