//
//  Core.swift
//  Comic Viewer
//
//  Created by Myles Eynon on 16/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//

import UIKit

public struct Core {
    
    private static var injector = DependencyInjector()
    
    public static func register<T>(_ factory: @escaping () -> T) {
        injector.register(factory)
    }
    
    public static let api: APIProtocol = {
        injector.resolve() as APIProtocol
    }()
}
