//
//  APIComics.swift
//  ComicKit
//
//  Created by Myles Eynon on 16/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//

import Foundation
import PromiseKit

//give our APIs a namespace once registered in the dependency injector: Core.api.comics.retrieveComics...
public protocol APIProtocol {
    var comics: APIComics { get }
}

public protocol APIComics {
    func retrieveComics(_ offset: Int, limit: Int) -> Promise<[Comic]>
}
