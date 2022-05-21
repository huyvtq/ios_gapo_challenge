//
//  CodableParseHelper.swift
//  MainApp
//
//  Created by HuyQuoc on 03/05/2022.
//

import Foundation
class CodableParseHelper {
    let decoder: JSONDecoder
    
    init () {
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        decoder.dateDecodingStrategy = .millisecondsSince1970
    }
    
    func parse<T: Codable>(data: Data) throws -> T {
        try decoder.decode(T.self, from: data)
    }
}
