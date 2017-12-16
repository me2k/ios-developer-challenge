//
//  PagedDataSource.swift
//  Comic Viewer
//
//  Created by Myles Eynon on 13/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//

import Foundation

open class PagedDataSource<T, V>: DataSource<T, V> where T : NSObject, V : NSObject {
    
    open var newestItems: [T] = []
    open var hasReachedLastPage = false
    open var page: Int = 0
    open var offset: Int = 0
    open var limit: Int {
        return 20
    }
    
    public func incrementPageAndOffset() {
        self.page = self.page + 1
        self.offset = self.offset + self.newestItems.count
    }
    
    public func reset() {
        self.page = 0
        self.offset = 0
        self.newestItems.removeAll()
        self.viewModels.removeAll()
        self.items.removeAll()
        self.hasReachedLastPage = false
    }
}




