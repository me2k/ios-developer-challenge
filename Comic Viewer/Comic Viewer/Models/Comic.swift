//
//  Comic.swift
//  Comic Viewer
//
//  Created by Myles Eynon on 13/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//

import SwiftyJSON

/*
 {
 "id": 21470,
 "digitalId": 0,
 "title": "Ultimate Spider-Man (Spanish Language Edition) (2000) #6",
 "issueNumber": 6,
 "variantDescription": "",
 "description": null,
 "modified": "-0001-11-30T00:00:00-0500",
 "isbn": "",
 "upc": "",
 "diamondCode": "",
 "ean": "",
 "issn": "",
 "format": "Comic",
 "pageCount": 36,
 "textObjects": [],
 "resourceURI": "http://gateway.marvel.com/v1/public/comics/21470",
 "urls": [{
 "type": "detail",
 "url": "http://marvel.com/comics/issue/21470/ultimate_spider-man_spanish_language_edition_2000_6?utm_campaign=apiRef&utm_source=17f0f488d9d2ba7a96e4adb9e0449c9a"
 }],
 "series": {
 "resourceURI": "http://gateway.marvel.com/v1/public/series/5105",
 "name": "Ultimate Spider-Man (Spanish Language Edition) (2000 - 2001)"
 },
 "variants": [],
 "collections": [],
 "collectedIssues": [],
 "dates": [{
 "type": "onsaleDate",
 "date": "2029-12-31T00:00:00-0500"
 },
 {
 "type": "focDate",
 "date": "-0001-11-30T00:00:00-0500"
 }
 ],
 "prices": [{
 "type": "printPrice",
 "price": 2.25
 }],
 "thumbnail": {
 "path": "http://i.annihil.us/u/prod/marvel/i/mg/b/40/image_not_available",
 "extension": "jpg"
 },
 "images": [],
 "creators": {
 "available": 0,
 "collectionURI": "http://gateway.marvel.com/v1/public/comics/21470/creators",
 "items": [],
 "returned": 0
 },
 "characters": {
 "available": 1,
 "collectionURI": "http://gateway.marvel.com/v1/public/comics/21470/characters",
 "items": [{
 "resourceURI": "http://gateway.marvel.com/v1/public/characters/1011010",
 "name": "Spider-Man (Ultimate)"
 }],
 "returned": 1
 },
 "stories": {
 "available": 2,
 "collectionURI": "http://gateway.marvel.com/v1/public/comics/21470/stories",
 "items": [{
 "resourceURI": "http://gateway.marvel.com/v1/public/stories/48968",
 "name": "Cover #48968",
 "type": "cover"
 },
 {
 "resourceURI": "http://gateway.marvel.com/v1/public/stories/48969",
 "name": "Interior #48969",
 "type": "interiorStory"
 }
 ],
 "returned": 2
 },
 "events": {
 "available": 0,
 "collectionURI": "http://gateway.marvel.com/v1/public/comics/21470/events",
 "items": [],
 "returned": 0
 }
 }
 
 */

class Comic: NSObject, JSONResponseProtocol {
    
    var id: Int = 0
    var title: String?
    var issueNumber: Int = 0
    var imagePath: String?
    var imageExt: String?
    var textObjects = [String]()
    var characters = [String]()
    
    static func fromJson(json: JSON) -> JSONResponseProtocol? {
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
