//
//  DataSource.swift
//  Comic Viewer
//
//  Created by Myles Eynon on 13/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//

import UIKit

public protocol DataSourceProtocol {}

public protocol DataSourceDelegate {
    func dataSourceDidStartUpdate(dataSource: DataSourceProtocol)
    func dataSourceDidUpdate(dataSource: DataSourceProtocol)
    func dataSourceDidFailToUpdate(error: Error?, httpCode: Int?, dataSource: DataSourceProtocol)
}

open class DataSource<T, V>: NSObject, DataSourceProtocol where T : NSObject, V : NSObject {
    
    open var isLoading: Bool = false
    
    open var items: [T] = []
    
    open var viewModels: [V] = []
    
    open var delegate: DataSourceDelegate?
    
    open var count: Int { return items.count }
    open subscript (index: Int) -> T { get { return items[index] } }
    
    open func clear() {}
}

public enum DataSourceError: Error {
    case notFound
    case badInput
}

