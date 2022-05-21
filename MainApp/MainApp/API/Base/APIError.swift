//
//  APIError.swift
//  MainApp
//
//  Created by HuyQuoc on 07/05/2022.
//

import Foundation
enum APIError: Error {
    case `default`
    case undefine(message: String)
    
    static func error(for statusCode: Int) -> APIError {
        return APIError.default
    }
}
