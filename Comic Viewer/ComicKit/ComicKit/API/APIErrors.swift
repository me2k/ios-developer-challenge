//
//  APIErrors.swift
//  Comic Viewer
//
//  Created by Myles Eynon on 14/12/2017.
//  Copyright © 2017 MylesEynon. All rights reserved.
//

import Foundation

public enum APIErrors: Error, LocalizedError {
    case noData
    
    var localizedDescription: String {
        switch self {
        case .noData:
            return NSLocalizedString("no_data_error", value: "No Data Available", comment: "No Data Error Message")
        }
    }
}
