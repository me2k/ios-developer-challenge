//
//  ComicsAPI.swift
//  ComicKit
//
//  Created by Myles Eynon on 16/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//

import Foundation
import PromiseKit
import SwiftyJSON

extension MarvelAPI {
    public struct ComicsAPI: APIComics {
    
        /** Requests a list of comics from Marvel's API */
        public func retrieveComics(_ offset: Int, limit: Int) -> Promise<[Comic]> {
            return Promise { fulfil, reject in
                
                debugPrint("retrieving Comics...")
                
                API.request(.comics(offset, limit)).then { json -> Void in
                    
                    debugPrint("...Comics Downloaded")
                    let itemsJson = json["data"]["results"]
                    if itemsJson != JSON.null, let comicItemsJson = itemsJson.array {
                        var items = [Comic]()
                        for comicItemJson in comicItemsJson {
                            if let comicItem = Comic.fromJson(json: comicItemJson) as? Comic {
                                items.append(comicItem)
                            }
                        }
                        fulfil(items)
                    } else {
                        reject(APIErrors.noData)
                    }
                }.catch { error in
                    reject(error)
                }
            }
        }
    }
}

