//
//  Comic.swift
//  Comic Viewer
//
//  Created by Myles Eynon on 13/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//

import SwiftyJSON

public class Comic: NSObject, JSONResponseProtocol {
    
    public var id: Int = 0
    public var title: String?
    public var issueNumber: Int = 0
    public var imagePath: String?
    public var imageExt: String?
    public var textObjects = [String]()
    public var characters = [String]()
    
    public static func fromJson(json: JSON) -> JSONResponseProtocol? {
        let comic = Comic()
        comic.id = json ~~> "id"
        comic.title = json ~~> "title"
        comic.issueNumber = json ~~> "issueNumber"
        
        let charactersJson = json["characters"]["items"]
        if charactersJson != JSON.null {
            for characterJson in charactersJson.arrayValue {
                let character: String = characterJson ~~> "name"
                comic.characters.append(character)
            }
        }
        
        let imagesJson = json["thumbnail"]
        if imagesJson != JSON.null {
            comic.imagePath = imagesJson ~~> "path"
            comic.imageExt = imagesJson ~~> "extension"
        }
        
        let textObjectsJson = json["textObjects"]
        if textObjectsJson != JSON.null {
            for textObjectJson in textObjectsJson.arrayValue {
                let textObject: String = textObjectJson ~~> "text"
                if let decodedString = String(htmlEncodedString: textObject) {
                    comic.textObjects.append(decodedString)
                }
            }
        }
        
        return comic
    }
    
}
