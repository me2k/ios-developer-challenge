//
//  IHasComicDataSource.swift
//  Comic Viewer
//
//  Created by Myles Eynon on 14/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//

import Foundation

public protocol IHasComicDataSource {
    var dataSource: ComicDataSource! { get set }
}
