//
//  ComicViewModel.swift
//  Comic Viewer
//
//  Created by Myles Eynon on 13/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//

import UIKit

enum ImageSize: String {
    case detail = "detail"
    case uncanny = "portrait_uncanny"
    //other image sizes would go here
    
    func imageUrl(withPath path: String?, imageExt: String?) -> URL? {
        guard let imagePath = path, let imgExt = imageExt else {
            return nil
        }
        return URL(string: "\(imagePath)/\(self.rawValue).\(imgExt)")
    }
}

public class ComicViewModel: NSObject {
    
    private var model: Comic!
    
    public init(withComic comic: Comic) {
        self.model = comic
    }
    
    public var title: String? {
        return self.model.title
    }
    
    public var itemDescription: String? {
        var description: String? = nil
        
        for block in self.model.textObjects {
            description = "\(description ?? "")\n\(block)"
        }
        
        return description
    }
    
    public var thumbnailImageURL: URL? {
        return ImageSize.uncanny.imageUrl(withPath: self.model.imagePath, imageExt: self.model.imageExt)
    }
    
    public var detailImageURL: URL? {
        return ImageSize.detail.imageUrl(withPath: self.model.imagePath, imageExt: self.model.imageExt)
    }
    
    public var characters: String? {
        var charactersBlock: String? = nil
        
        for character in self.model.characters {
            charactersBlock = "\(charactersBlock ?? "")\n\(character)"
        }
        
        return charactersBlock
    }
}
