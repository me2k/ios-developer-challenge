//
//  MocAPIProtocols.swift
//  ComicKit
//
//  Created by Myles Eynon on 16/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//

import Foundation
import PromiseKit

public class MocAPI: APIProtocol {
    
    fileprivate static var delay: TimeInterval = 0
    
    public init(delay: TimeInterval) {
        MocAPI.delay = delay
    }
    
    public var comics: APIComics = MocComics()
}

public struct MocComics: APIComics {
    public func retrieveComics(_ offset: Int, limit: Int) -> Promise<[Comic]> {
        return Promise { fulfil, reject in
            
            _ = after(interval: MocAPI.delay).always {
                
                var items = [Comic]()
                
                items.append(ComicDataSource.createDummyComic())
                items.append(ComicDataSource.createDummyComic2())
                items.append(ComicDataSource.createDummyComic3())
                fulfil(items)
            }
            
        }
    }

}
