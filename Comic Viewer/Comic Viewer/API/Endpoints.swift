//
//  Endpoints.swift
//  Comic Viewer
//
//  Created by Myles Eynon on 14/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//

import Alamofire
import SwiftHash

enum Endpoints: URLRequestConvertible {
    
    /** Get images with tags and userIds */
    case comics(Int, Int)
    
    // Path for the request
    private var path: String {
        switch self {
            
        case .comics:
            return "/v1/public/comics"
        }
    }
    
    // Request type, GET by default, if there were other APIs that required PUT ot POST, that would be specified here
    private var methodType: HTTPMethod {
        return .get
    }
    
    // The optional request parameters if required.
    private var parameters: Parameters? {
        let timeInterval: Int = Int(Date().timeIntervalSince1970)
        let hash = MD5(String(timeInterval) + Constants.apiPrivateKey + Constants.apiPublicKey).lowercased()
        var parameters: Parameters = [ "apikey" : Constants.apiPublicKey,
                                           "ts" : timeInterval,
                                           "hash" : hash]
        switch self {
        case .comics(let offset, let limit):
            parameters["offset"] = offset
            parameters["limit"] = limit
        default:
            break
        }
        return parameters
    }
    
    // Encoding type for parameters
    private var encodingType: ParameterEncoding {
        return URLEncoding.default
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try Constants.baseAPIUrl.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        urlRequest.httpMethod = methodType.rawValue
        
        if let parameters = parameters {
            urlRequest = try encodingType.encode(urlRequest, with: parameters)
        }
        
        return urlRequest
    }
}
