//
//  APIClient.swift
//  MainApp
//
//  Created by HuyQuoc on 03/05/2022.
//

import Foundation
protocol APIClient {
    func get<T: Codable, Parameters: Encodable>(endPoint: String,
                                                parameters: Parameters?,
                                                parse: T.Type,
                                                complete: ((T)->())?,
                                                failure: ((Error) -> ())?)
}
