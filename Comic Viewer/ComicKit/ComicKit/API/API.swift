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

enum MarvelAPI {}

public class API: APIProtocol {
    
    public static let instance = API() //we use a static class to keep the sessionManager alive for the duration of the app.
    
    public var comics: APIComics = MarvelAPI.ComicsAPI()
    
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
