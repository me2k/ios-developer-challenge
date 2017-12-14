//
//  API.swift
//  Comic Viewer
//
//  Created by Myles Eynon on 13/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//

import PromiseKit
import SwiftyJSON
import Alamofire

class API {
    
    static let instance = API() //we use a static class to keep the sessionManager alive for the duration of the app.
    
    private var sessionManager: SessionManager = {
        return API.createSession()
    }()
    
    /** create the API session that will last the lifetime of the app */
    static private func createSession() -> SessionManager {
        debugPrint("sessionManager - createSession")
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = SessionManager.defaultHTTPHeaders
        configuration.timeoutIntervalForResource = 60.0
        configuration.timeoutIntervalForRequest = 60.0
        
        let sessionManager = Alamofire.SessionManager(configuration: configuration)
        return sessionManager
    }
    
    /** Cancels all api requests on the session manager, and recreates a new manager */
    func cancel() {
        debugPrint("API - cancel")
        sessionManager.session.invalidateAndCancel() //this action requires the session to be recreated
        sessionManager = API.createSession()
    }
    
    /** Perorm a request */
    internal static func request(_ endpoint: Endpoints) -> Promise<JSON> {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        return Promise<JSON> { fulfil, reject in
            
            let responseBlock = { (response: DataResponse<Data>) in
                
                switch response.result {
                case .success:
                    
                    if let result = response.result.value, let json = try? JSON(data: result) {
                        fulfil(json)
                    } else {
                        reject(APIErrors.noData)
                    }
                    
                case .failure(let error) :
                    debugPrint("call failed: \(error)")
                    reject(error)
                }
                
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
            
            instance.sessionManager.request(endpoint).validate().responseData(completionHandler: responseBlock)
        }
    }
}

extension API {
    
    /** Requests a list of comics from Marvel's API */
    func retrieveComics(_ offset: Int, limit: Int) -> Promise<[Comic]> {
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



