//
//  ComicDataSource.swift
//  Comic Viewer
//
//  Created by Myles Eynon on 13/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//

import PromiseKit

open class ComicDataSource: PagedDataSource<Comic, ComicViewModel> {
    
    // MARK: Constants
    
    open let initialSkip: Int = 200 //skip first 200 comics as they don't all have images
    
    //MARK: Methods
    
    override public init() {
        super.init()
        self.offset = initialSkip
    }
    
    override public func reset() {
        super.reset()
        self.offset = initialSkip
    }
    
    open func reload() {
        guard !self.isLoading else { return }
        self.isLoading = true
        DispatchQueue.main.async {
            // this is not called on the main thread
            self.delegate?.dataSourceDidStartUpdate(dataSource: self)
        }
        firstly {
            return Core.api.comics.retrieveComics(self.offset, limit: self.limit)
        }.then { comics -> Void in
            debugPrint("Downloaded \(comics.count) comics")
            if comics.count == 0 {
                self.isLoading = false
                self.hasReachedLastPage = true
                self.delegate?.dataSourceDidUpdate(dataSource: self)
                return
            }
            
            self.newestItems = comics
            self.items.append(contentsOf: comics)
            self.incrementPageAndOffset()
            self.addViewModels(withNewItems: comics)
            self.isLoading = false
            self.delegate?.dataSourceDidUpdate(dataSource: self)
        }.catch { error in
            self.isLoading = false
            self.delegate?.dataSourceDidFailToUpdate(error: error, httpCode: nil, dataSource: self)
        }
    }
    
    open func addViewModels(withNewItems newItems: [Comic]) {
        for item in newItems {
            self.viewModels.append(ComicViewModel(withComic: item))
        }
    }
    
    open func getNextComic(withComicVM comicVM: ComicViewModel) -> ComicViewModel? {
        if let index = self.viewModels.index(of: comicVM), (index + 1) < self.viewModels.count {
            return self.viewModels[index + 1]
        }
        return nil
    }
    
    open func getPreviousComic(withComicVM comicVM: ComicViewModel) -> ComicViewModel? {
        if let index = self.viewModels.index(of: comicVM), (index - 1) < self.viewModels.count && (index - 1) > 0 {
            return self.viewModels[index - 1]
        }
        return nil
    }
    
    // MARK: Static methods
    
    static func createDummyComic() -> Comic {
        let item = Comic()
        item.id = 12345
        item.characters = ["Spider man", "Mary Jane", "Uncle Ben", "Dr Octopus"]
        item.imagePath = "http://i.annihil.us/u/prod/marvel/i/mg/2/e0/5a31a3494057b"
        item.imageExt = "jpg"
        item.issueNumber = 1
        item.textObjects = ["Object 1", "Object 2"]
        item.title = "Spider Man"
        return item
    }
    
    static func createDummyComic2() -> Comic {
        let item = Comic()
        item.id = 12346
        item.characters = ["Tony Stark", "Miss Potts"]
        item.issueNumber = 1
        item.textObjects = ["Object 1", "Object 2"]
        item.title = "Iron Man"
        return item
    }
    
    static func createDummyComic3() -> Comic {
        let item = Comic()
        item.id = 12347
        item.characters = ["Wolverine", "Professor X", "Cyclops"]
        item.imagePath = "http://i.annihil.us/u/prod/marvel/i/mg/5/e0/5a31a369f34c0"
        item.imageExt = "jpg"
        item.issueNumber = 1
        item.textObjects = ["Object 1", "Object 2"]
        item.title = "X Men"
        return item
    }
}
